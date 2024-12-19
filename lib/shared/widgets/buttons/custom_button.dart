import 'package:easy_manga_editor/shared/widgets/loading/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpand;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final Widget? leading;
  final Widget? trailing;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isExpand = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        elevation: 0,
      ),
      child: _buildChild(theme),
    );

    if (isExpand) {
      return SizedBox(
        width: double.infinity,
        height: height ?? AppDimensions.buttonHeight,
        child: button,
      );
    }

    return SizedBox(
      width: width,
      height: height ?? AppDimensions.buttonHeight,
      child: button,
    );
  }

  Widget _buildChild(ThemeData theme) {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: LoadingIndicator(),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: AppTextStyles.button,
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing!,
        ],
      ],
    );
  }
}
