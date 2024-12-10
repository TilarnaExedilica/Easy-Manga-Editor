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
      duration: const Duration(milliseconds: 300),
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

    // Xử lý drawer bên trái
    if (widget.leftDrawer != null && !_isRightDrawerOpen) {
      if (!_isLeftDrawerOpen && delta > 0) {
        // Vuốt phải -> mở drawer trái
        _controller.value = (delta / widget.drawerWidth).clamp(0.0, 1.0);
      } else if (_isLeftDrawerOpen) {
        // Vuốt trái -> đóng drawer trái
        _controller.value = (1 + delta / widget.drawerWidth).clamp(0.0, 1.0);
      }
    }

    // Xử lý drawer bên phải
    if (widget.rightDrawer != null && !_isLeftDrawerOpen) {
      if (!_isRightDrawerOpen && delta < 0) {
        // Vuốt trái -> mở drawer phải
        _controller.value = (-delta / widget.drawerWidth).clamp(0.0, 1.0);
      } else if (_isRightDrawerOpen) {
        // Vuốt phải -> đóng drawer phải
        _controller.value = (1 - delta / widget.drawerWidth).clamp(0.0, 1.0);
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.enableGesture || _dragStartX == null) return;

    // Xác định trạng thái cuối cùng dựa trên giá trị controller và velocity
    final velocity = details.velocity.pixelsPerSecond.dx;

    // Cập nhật trạng thái dựa trên velocity và giá trị controller
    if (widget.leftDrawer != null && !_isRightDrawerOpen) {
      _isLeftDrawerOpen = velocity > 0 || _controller.value > 0.5;
    }
    if (widget.rightDrawer != null && !_isLeftDrawerOpen) {
      _isRightDrawerOpen = velocity < 0 || _controller.value > 0.5;
    }

    final targetValue = (_isLeftDrawerOpen || _isRightDrawerOpen) ? 1.0 : 0.0;
    final currentValue = _controller.value;

    final velocityAbs = velocity.abs();
    final remainingDistance = (targetValue - currentValue).abs();

    final baseDuration = 800;
    final velocityFactor = (1.0 - (velocityAbs / 2000).clamp(0.0, 0.8));

    final animationDuration = Duration(
      milliseconds: (baseDuration * remainingDistance * velocityFactor).round(),
    );

    _controller.animateTo(
      targetValue,
      curve: Curves.easeOutExpo,
      duration: animationDuration,
    );

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
          animation: CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
          ),
          builder: (context, child) {
            // Tính toán offset cho body
            double bodyOffset = 0.0;
            if (_isLeftDrawerOpen ||
                (!_isRightDrawerOpen && _controller.value > 0)) {
              bodyOffset = widget.drawerWidth * _controller.value;
            } else if (_isRightDrawerOpen ||
                (!_isLeftDrawerOpen && _controller.value > 0)) {
              bodyOffset = -widget.drawerWidth * _controller.value;
            }

            return Stack(
              children: [
                // Body
                Transform.translate(
                  offset: Offset(bodyOffset, 0),
                  child: Container(
                    color: widget.backgroundColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                    child: widget.body,
                  ),
                ),
                // Left drawer
                if (widget.leftDrawer != null)
                  Transform.translate(
                    offset: Offset(
                      -widget.drawerWidth * (1 - _controller.value),
                      0,
                    ),
                    child: Opacity(
                      opacity: _controller.value,
                      child: widget.leftDrawer!,
                    ),
                  ),
                // Right drawer
                if (widget.rightDrawer != null)
                  Positioned(
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(
                        widget.drawerWidth * (1 - _controller.value),
                        0,
                      ),
                      child: Opacity(
                        opacity: _controller.value,
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
