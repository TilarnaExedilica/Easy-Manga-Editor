import 'package:easy_manga_editor/shared/widgets/buttons/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';

class CustomPageOverlay extends StatelessWidget {
  final Widget child;
  final VoidCallback onClose;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const CustomPageOverlay({
    super.key,
    required this.child,
    required this.onClose,
    this.backgroundColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.85,
        height: height ?? MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.dialogTheme.backgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.radius),
          border: Border.all(
            color: theme.colorScheme.outline,
            width: AppDimensions.borderWidth,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Content
            Padding(
              padding: const EdgeInsets.all(AppDimensions.padding),
              child: child,
            ),

            // Close button
            Positioned(
              top: 0,
              right: 0,
              child: AppIconButton(
                icon: Broken.close_circle,
                onPressed: onClose,
                size: AppDimensions.iconMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method để show overlay
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    Color? backgroundColor,
    double? width,
    double? height,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CustomPageOverlay(
        onClose: () => Navigator.of(context).pop(),
        backgroundColor: backgroundColor,
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
