import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:flutter/material.dart';

class SettingSelection extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final Function(String) onChanged;

  const SettingSelection({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  State<SettingSelection> createState() => _SettingSelectionState();
}

class _SettingSelectionState extends State<SettingSelection> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.items.map((item) {
        final isSelected = item == widget.selectedItem;
        return SizedBox(
          child: GestureDetector(
            onTap: () => widget.onChanged(item),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingSmall,
                  horizontal: AppDimensions.padding),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
