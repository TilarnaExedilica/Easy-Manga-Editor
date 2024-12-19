import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SettingSection extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const SettingSection({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  State<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingSmall,
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: AppDimensions.iconMedium,
                ),
                const SizedBox(width: AppDimensions.spacing),
                Expanded(
                  child: Text(
                    widget.title,
                    style: AppTextStyles.bodyMedium,
                    overflow: TextOverflow.visible,
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: _isExpanded ? 0.5 : 0,
                  child: const Icon(
                    Broken.arrow_down_2,
                    size: AppDimensions.iconMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: SizedBox(
              height: _isExpanded ? null : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isExpanded ? 1.0 : 0.0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  offset: Offset(0, _isExpanded ? 0 : -0.1),
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: AppDimensions.paddingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
