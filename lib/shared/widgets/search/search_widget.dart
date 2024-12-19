import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';

class SearchWidget extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;
  final TextEditingController? controller;
  final bool isSearching;
  final Widget? resultSearch;
  final double resultHeight;

  const SearchWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSearch,
    this.controller,
    this.isSearching = false,
    this.resultSearch,
    this.resultHeight = 435,
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
                  autofocus: false,
                  focusNode: FocusNode(),
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
                height:
                    AppDimensions.buttonHeight - AppDimensions.paddingSmall * 2,
                color: theme.colorScheme.outline,
                margin: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingSmall,
                ),
              ),
              IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    widget.isSearching
                        ? Broken.close_circle
                        : Broken.search_normal,
                    key: ValueKey<bool>(widget.isSearching),
                    size: AppDimensions.iconMedium,
                  ),
                ),
                onPressed: widget.onSearch,
              ),
            ],
          ),
        ),
        if (widget.resultSearch != null)
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            margin: const EdgeInsets.only(top: AppDimensions.paddingSmall),
            height: widget.isSearching ? widget.resultHeight : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radius),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  opacity: widget.isSearching ? 1.0 : 0.0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    scale: widget.isSearching ? 1.0 : 0.95,
                    child: Container(
                      height: widget.resultHeight,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radius),
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: AppDimensions.borderWidth,
                        ),
                      ),
                      child: widget.resultSearch!,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
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
