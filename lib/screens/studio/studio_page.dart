import 'package:easy_manga_editor/shared/widgets/drawer/control_drawer.dart';
import 'package:easy_manga_editor/shared/widgets/drawer/tools_drawer.dart';
import 'package:easy_manga_editor/shared/widgets/loading/loading_indicator.dart';
import 'package:easy_manga_editor/shared/widgets/scaffold/extend_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:ui' as ui;

@RoutePage()
class StudioPage extends StatefulWidget {
  const StudioPage({super.key});

  @override
  State<StudioPage> createState() => _StudioPageState();
}

class TextOverlayPainter extends CustomPainter {
  final List<TextBlock> textBlocks;
  final Map<String, String> translations;
  final Size imageSize;
  final Size displaySize;

  TextOverlayPainter({
    required this.textBlocks,
    required this.translations,
    required this.imageSize,
    required this.displaySize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = displaySize.width / imageSize.width;
    final double scaleY = displaySize.height / imageSize.height;

    for (var block in textBlocks) {
      final originalText = block.text;
      final translatedText = translations[originalText] ?? '';

      final Rect originalRect = block.boundingBox;
      final Rect scaledRect = Rect.fromLTWH(
        originalRect.left * scaleX,
        originalRect.top * scaleY,
        originalRect.width * scaleX,
        originalRect.height * scaleY,
      );

      final paint = Paint()
        ..color = Colors.white
        // TODO: Change color/opacity text background
        ..style = PaintingStyle.fill;
      canvas.drawRect(scaledRect, paint);

      _drawFittedText(
        canvas: canvas,
        text: translatedText,
        rect: scaledRect,
      );
    }
  }

  void _drawFittedText({
    required Canvas canvas,
    required String text,
    required Rect rect,
  }) {
    double fontSize = 20.0;
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: ui.TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    while (true) {
      textPainter.text = TextSpan(
        text: text,
        style: textStyle.copyWith(fontSize: fontSize),
      );

      textPainter.layout(maxWidth: rect.width);

      if (textPainter.height <= rect.height &&
          textPainter.width <= rect.width) {
        break;
      }

      fontSize -= 0.5;

      if (fontSize < 8) {
        fontSize = 8;
        break;
      }
    }

    textPainter.text = TextSpan(
      text: text,
      style: textStyle.copyWith(fontSize: fontSize),
    );
    textPainter.layout(maxWidth: rect.width);

    final xCenter = rect.left + (rect.width - textPainter.width) / 2;
    final yCenter = rect.top + (rect.height - textPainter.height) / 2;

    textPainter.paint(canvas, Offset(xCenter, yCenter));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _StudioPageState extends State<StudioPage> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  final OnDeviceTranslator _translator = OnDeviceTranslator(
    sourceLanguage: TranslateLanguage.english,
    targetLanguage: TranslateLanguage.vietnamese,
  );
  String recognizedText = '';
  String translatedText = '';
  bool isProcessing = false;
  String? errorMessage;
  List<TextBlock> textBlocks = [];
  Map<String, String> translations = {};

  final String imageUrl =
      'https://i.ibb.co/0MyTJhc/3387f0f6-45ba-4bd7-b4e1-3665c5d943b6.jpg';

  Size? _imageSize;

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  Future<void> processImage(String imageUrl) async {
    setState(() {
      isProcessing = true;
      textBlocks = [];
      translations.clear();
    });

    try {
      final InputImage inputImage = InputImage.fromFilePath(imageUrl);
      final RecognizedText result =
          await _textRecognizer.processImage(inputImage);

      for (var block in result.blocks) {
        final originalText = block.text;
        final translatedText = await _translator.translateText(originalText);
        translations[originalText] = translatedText;

        if (kDebugMode) {
          print('Original text: $originalText');
        }
        if (kDebugMode) {
          print('Translated text: $translatedText');
        }
      }

      setState(() {
        textBlocks = result.blocks;
      });

      if (kDebugMode) {
        print('Number of text blocks: ${textBlocks.length}');
      }
      if (kDebugMode) {
        print('Number of translations: ${translations.length}');
      }
      if (kDebugMode) {
        print('Translations map: $translations');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in processImage: $e');
      }
      setState(() {
        errorMessage = 'Có lỗi xảy ra: $e';
      });
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  Future<String> _downloadAndSaveImage(String imageUrl) async {
    try {
      final dio = Dio();
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final String filePath = '$tempPath/temp_image.jpg';

      await dio.download(
        imageUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            if (kDebugMode) {
              print('${(received / total * 100).toStringAsFixed(0)}%');
            }
          }
        },
      );

      return filePath;
    } catch (e) {
      throw Exception('Failed to download and save image: $e');
    }
  }

  Future<void> _loadImage(String imageUrl) async {
    final ImageStream stream =
        NetworkImage(imageUrl).resolve(ImageConfiguration.empty);
    final Completer<ui.Image> completer = Completer<ui.Image>();

    late ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      stream.removeListener(listener);
      completer.complete(frame.image);
    });

    stream.addListener(listener);
    final ui.Image image = await completer.future;
    setState(() {
      _imageSize = Size(image.width.toDouble(), image.height.toDouble());
    });
  }

  Future<void> _exportImage() async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/exported_image.png';
      final File file = File(filePath);
      await file.writeAsBytes(pngBytes);

      await Clipboard.setData(ClipboardData(text: filePath));

      if (kDebugMode) {
        print('Đã xuất ảnh và copy đường dẫn vào clipboard: $filePath');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi xuất ảnh: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ExtendScaffold(
      leftDrawer: const ControlDrawer(),
      rightDrawer: const ToolsDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
              key: _repaintBoundaryKey,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (_imageSize == null) {
                    return const Center(child: LoadingIndicator());
                  }

                  final displaySize = Size(
                    constraints.maxWidth,
                    constraints.maxWidth *
                        (_imageSize!.height / _imageSize!.width),
                  );

                  return Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        width: displaySize.width,
                        height: displaySize.height,
                        fit: BoxFit.contain,
                      ),
                      if (textBlocks.isNotEmpty)
                        CustomPaint(
                          painter: TextOverlayPainter(
                            textBlocks: textBlocks,
                            translations: translations,
                            imageSize: _imageSize!,
                            displaySize: displaySize,
                          ),
                          child: SizedBox(
                            width: displaySize.width,
                            height: displaySize.height,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _exportImage,
              child: const Text('Xuất ảnh'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: isProcessing
                        ? null
                        : () async {
                            final String localPath =
                                await _downloadAndSaveImage(imageUrl);
                            await processImage(localPath);
                          },
                    child: isProcessing
                        ? const LoadingIndicator()
                        : const Text('Nhận dạng và dịch'),
                  ),
                  const SizedBox(height: 16),
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textRecognizer.close();
    _translator.close();
    super.dispose();
  }
}
