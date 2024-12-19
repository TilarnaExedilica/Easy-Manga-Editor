import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;

  const SettingsItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle item tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.padding,
          vertical: AppDimensions.paddingSmall,
        ),
        child: Text(
          title,
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }
}
