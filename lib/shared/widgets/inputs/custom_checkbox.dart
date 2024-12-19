import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final TextStyle? labelStyle;
  final OutlinedBorder? checkboxShape;
  final Color? activeColor;
  final Color? checkColor;

  const CustomCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.labelStyle,
    this.checkboxShape,
    this.activeColor,
    this.checkColor,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.value;
  }

  @override
  void didUpdateWidget(CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _checked = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _checked = !_checked;
        });
        widget.onChanged(_checked);
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: AppDimensions.iconMedium,
            height: AppDimensions.iconMedium,
            decoration: BoxDecoration(
              border: Border.all(
                color: _checked
                    ? widget.activeColor ??
                        Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              color: _checked
                  ? widget.activeColor ?? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            ),
            child: _checked
                ? Icon(
                    Broken.tick_square,
                    size: 16,
                    color: widget.checkColor ?? Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: AppDimensions.spacing),
          Expanded(
            child: Text(
              widget.label,
              style:
                  widget.labelStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
