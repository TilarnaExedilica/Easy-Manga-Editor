import 'package:easy_manga_editor/app/theme/styles/colors.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:flutter/material.dart';

class SettingSelection extends StatelessWidget {
  final List<SettingOption> items;
  final String selectedItem;
  final Function(String) onChanged;

  const SettingSelection({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppDimensions.paddingSmall,
      runSpacing: AppDimensions.paddingSmall,
      children: items.map((item) {
        final isSelected = item.value == selectedItem;
        return InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.radius),
          onTap: () => onChanged(item.value),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.padding,
                vertical: AppDimensions.paddingSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radius),
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: AppDimensions.iconMedium,
                    color: isSelected
                        ? AppColors.textDark
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppDimensions.paddingSmall),
                ],
                Text(
                  item.label,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.textDark
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SettingOption {
  final String label;
  final String value;
  final IconData? icon;

  const SettingOption({
    required this.label,
    required this.value,
    this.icon,
  });
}
