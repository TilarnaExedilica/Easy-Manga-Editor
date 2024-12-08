import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final double? elevation;
  final BorderRadius? borderRadius;

  const BaseCard({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.onTap,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation ?? 1,
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppDimensions.radius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppDimensions.radius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppDimensions.padding),
          child: child,
        ),
      ),
    );
  }
}
