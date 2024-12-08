import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';

class AppDecorations {
  // Box Decorations
  static BoxDecoration roundedBox({
    Color? color,
    Color? borderColor,
    double? radius,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius ?? AppDimensions.radius),
      border: borderColor != null ? Border.all(color: borderColor) : null,
      boxShadow: shadows,
    );
  }

  // Input Decorations
  static InputDecoration inputDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      errorText: errorText,
      contentPadding: const EdgeInsets.all(AppDimensions.padding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radius),
      ),
    );
  }

  // Card Decorations
  static BoxDecoration cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(AppDimensions.radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
