import 'package:flutter/material.dart';
import 'package:easy_manga_editor/core/utils/constants/ui_constants.dart';

class ExtendScaffold extends StatefulWidget {
  final Widget body;
  final Widget? leftDrawer;
  final Widget? rightDrawer;
  final double drawerWidth;
  final Color? backgroundColor;
  final bool enableGesture;

  const ExtendScaffold({
    super.key,
    required this.body,
    this.leftDrawer,
    this.rightDrawer,
    this.drawerWidth = UIConstants.drawerWidth,
    this.backgroundColor,
    this.enableGesture = true,
  });

  @override
  State<ExtendScaffold> createState() => _ExtendScaffoldState();
}

class _ExtendScaffoldState extends State<ExtendScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLeftDrawerOpen = false;
  bool _isRightDrawerOpen = false;

  double? _dragStartX;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.enableGesture) return;
    _dragStartX = details.globalPosition.dx;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.enableGesture || _dragStartX == null) return;

    final delta = details.globalPosition.dx - _dragStartX!;

    if (widget.leftDrawer != null && !_isRightDrawerOpen) {
      if (_isLeftDrawerOpen) {
        _controller.value = 1 - (-delta / widget.drawerWidth);
        _isLeftDrawerOpen = _controller.value > 0.5;
      } else {
        _controller.value = delta / widget.drawerWidth;
        _isLeftDrawerOpen = _controller.value > 0.5;
      }
    } else if (widget.rightDrawer != null && !_isLeftDrawerOpen) {
      if (_isRightDrawerOpen) {
        _controller.value = 1 - (delta / widget.drawerWidth);
        _isRightDrawerOpen = _controller.value > 0.5;
      } else {
        _controller.value = -delta / widget.drawerWidth;
        _isRightDrawerOpen = _controller.value > 0.5;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.enableGesture || _dragStartX == null) return;

    if (_isLeftDrawerOpen) {
      _controller.animateTo(1.0);
    } else if (_isRightDrawerOpen) {
      _controller.animateTo(1.0);
    } else {
      _controller.animateTo(0.0);
    }

    _dragStartX = null;
  }

  void closeDrawers() {
    _controller.animateTo(0.0);
    _isLeftDrawerOpen = false;
    _isRightDrawerOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        onHorizontalDragStart: _handleDragStart,
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                Transform.translate(
                  offset: Offset(
                    _isLeftDrawerOpen
                        ? widget.drawerWidth * _controller.value
                        : _isRightDrawerOpen
                            ? -widget.drawerWidth * _controller.value
                            : 0.0,
                    0,
                  ),
                  child: Container(
                    color: widget.backgroundColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                    child: widget.body,
                  ),
                ),
                if (widget.leftDrawer != null)
                  Transform.translate(
                    offset: Offset(
                      -widget.drawerWidth * (1 - _controller.value),
                      0,
                    ),
                    child: Visibility(
                      visible: _controller.value > 0 && _isLeftDrawerOpen,
                      child: widget.leftDrawer!,
                    ),
                  ),
                if (widget.rightDrawer != null)
                  Positioned(
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(
                        widget.drawerWidth * (1 - _controller.value),
                        0,
                      ),
                      child: Visibility(
                        visible: _controller.value > 0 && _isRightDrawerOpen,
                        child: widget.rightDrawer!,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
