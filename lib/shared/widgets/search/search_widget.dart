import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';

class SearchWidget extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;
  final TextEditingController? controller;

  const SearchWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSearch,
    this.controller,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
    widget.onChanged?.call(_controller.text);
  }

  Future<void> _handlePaste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      _controller.text = data!.text!;
    }
  }

  void _handleClear() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppDimensions.buttonHeight,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.radius),
        border: Border.all(
          color: theme.colorScheme.outline,
          width: AppDimensions.borderWidth,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.padding,
                ),
                suffixIcon: _hasText
                    ? IconButton(
                        icon: const Icon(
                          Broken.close_circle,
                          size: AppDimensions.iconMedium,
                        ),
                        onPressed: _handleClear,
                      )
                    : IconButton(
                        icon: const Icon(
                          Broken.document_copy,
                          size: AppDimensions.iconMedium,
                        ),
                        onPressed: _handlePaste,
                      ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: AppDimensions.buttonHeight - AppDimensions.paddingSmall * 2,
            color: theme.colorScheme.outline,
            margin: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingSmall,
            ),
          ),
          IconButton(
            icon: const Icon(
              Broken.search_normal,
              size: AppDimensions.iconMedium,
            ),
            onPressed: widget.onSearch,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
