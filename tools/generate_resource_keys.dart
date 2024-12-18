// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  generateImageKeys();
  generateIconKeys();
}

void generateImageKeys() {
  final directory = Directory('assets/images');
  if (!directory.existsSync()) return;

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// ignore_for_file: constant_identifier_names');
  buffer.writeln();
  buffer.writeln('class TrImage {');
  buffer.writeln();

  final List<FileSystemEntity> files = directory.listSync(recursive: true);
  for (var file in files) {
    if (file is File &&
        (file.path.endsWith('.png') || file.path.endsWith('.jpg'))) {
      final fileName = file.path.split(Platform.isWindows ? '\\' : '/').last;
      final keyName = _formatKeyName(fileName);
      final relativePath = 'assets/images/$fileName'.replaceAll('\\', '/');
      buffer.writeln('  static const String $keyName = \'$relativePath\';');
    }
  }

  buffer.writeln('}');

  final outputFile = File('lib/app/tr/tr_image.dart');
  outputFile.writeAsStringSync(buffer.toString());
  print('Generated tr_image.dart successfully!');
}

void generateIconKeys() {
  final directory = Directory('assets/icons');
  if (!directory.existsSync()) return;

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// ignore_for_file: constant_identifier_names');
  buffer.writeln();
  buffer.writeln('class TrIcon {');
  buffer.writeln();

  final List<FileSystemEntity> files = directory.listSync(recursive: true);
  for (var file in files) {
    if (file is File &&
        (file.path.endsWith('.png') || file.path.endsWith('.svg'))) {
      final fileName = file.path.split(Platform.isWindows ? '\\' : '/').last;
      final keyName = _formatKeyName(fileName);
      final relativePath = 'assets/icons/$fileName'.replaceAll('\\', '/');
      buffer.writeln('  static const String $keyName = \'$relativePath\';');
    }
  }

  buffer.writeln('}');

  final outputFile = File('lib/app/tr/tr_icon.dart');
  outputFile.writeAsStringSync(buffer.toString());
  print('Generated tr_icon.dart successfully!');
}

String _formatKeyName(String fileName) {
  final nameWithoutExtension = fileName.split('.').first;

  final words = nameWithoutExtension.split(RegExp(r'[_\- ]'));
  final formattedWords = words.map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join('');

  return formattedWords[0].toLowerCase() + formattedWords.substring(1);
}
