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
    with TickerProviderStateMixin {
  late AnimationController _leftController;
  late AnimationController _rightController;
  bool _isLeftDrawerOpen = false;
  bool _isRightDrawerOpen = false;
  double? _dragStartX;

  @override
  void initState() {
    super.initState();
    _leftController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.enableGesture) return;
    _dragStartX = details.globalPosition.dx;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.enableGesture || _dragStartX == null) return;

    final delta = details.globalPosition.dx - _dragStartX!;

    if (delta > 0) {
      if (widget.leftDrawer != null && !_isRightDrawerOpen) {
        if (!_isLeftDrawerOpen) {
          _leftController.value = (delta / widget.drawerWidth).clamp(0.0, 1.0);
        }
      } else if (_isRightDrawerOpen) {
        _rightController.value =
            (1 - delta / widget.drawerWidth).clamp(0.0, 1.0);
      }
    } else if (delta < 0) {
      if (widget.rightDrawer != null && !_isLeftDrawerOpen) {
        if (!_isRightDrawerOpen) {
          _rightController.value =
              (-delta / widget.drawerWidth).clamp(0.0, 1.0);
        }
      } else if (_isLeftDrawerOpen) {
        _leftController.value =
            (1 + delta / widget.drawerWidth).clamp(0.0, 1.0);
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.enableGesture || _dragStartX == null) return;

    final velocity = details.velocity.pixelsPerSecond.dx;

    if (_isLeftDrawerOpen) {
      _isLeftDrawerOpen = velocity > -200 && _leftController.value > 0.5;
      final targetValue = _isLeftDrawerOpen ? 1.0 : 0.0;
      _animateDrawer(_leftController, targetValue, velocity);
    } else if (_isRightDrawerOpen) {
      _isRightDrawerOpen = velocity < 200 && _rightController.value > 0.5;
      final targetValue = _isRightDrawerOpen ? 1.0 : 0.0;
      _animateDrawer(_rightController, targetValue, velocity);
    } else {
      if (widget.leftDrawer != null && velocity > 200) {
        _isLeftDrawerOpen = true;
        _animateDrawer(_leftController, 1.0, velocity);
      } else if (widget.rightDrawer != null && velocity < -200) {
        _isRightDrawerOpen = true;
        _animateDrawer(_rightController, 1.0, velocity);
      } else {
        if (velocity >= 0) {
          _isLeftDrawerOpen = _leftController.value > 0.5;
          _animateDrawer(
              _leftController, _isLeftDrawerOpen ? 1.0 : 0.0, velocity);
        } else {
          _isRightDrawerOpen = _rightController.value > 0.5;
          _animateDrawer(
              _rightController, _isRightDrawerOpen ? 1.0 : 0.0, velocity);
        }
      }
    }

    _dragStartX = null;
  }

  void _animateDrawer(
      AnimationController controller, double targetValue, double velocity) {
    final currentValue = controller.value;
    final velocityAbs = velocity.abs();
    final remainingDistance = (targetValue - currentValue).abs();

    const baseDuration = 800;
    final velocityFactor = (1.0 - (velocityAbs / 2000).clamp(0.0, 0.8));

    final animationDuration = Duration(
      milliseconds: (baseDuration * remainingDistance * velocityFactor).round(),
    );

    controller.animateTo(
      targetValue,
      curve: Curves.easeOutExpo,
      duration: animationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        onHorizontalDragStart: _handleDragStart,
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        child: Stack(
          children: [
            // Body
            AnimatedBuilder(
              animation: Listenable.merge([_leftController, _rightController]),
              builder: (context, child) {
                double offset = 0.0;
                if (_isLeftDrawerOpen || _leftController.value > 0) {
                  offset = widget.drawerWidth * _leftController.value;
                } else if (_isRightDrawerOpen || _rightController.value > 0) {
                  offset = -widget.drawerWidth * _rightController.value;
                }
                return Transform.translate(
                  offset: Offset(offset, 0),
                  child: Container(
                    color: widget.backgroundColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                    child: widget.body,
                  ),
                );
              },
            ),
            // Left drawer
            if (widget.leftDrawer != null)
              AnimatedBuilder(
                animation: _leftController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      -widget.drawerWidth * (1 - _leftController.value),
                      0,
                    ),
                    child: Opacity(
                      opacity: _leftController.value,
                      child: SafeArea(child: widget.leftDrawer!),
                    ),
                  );
                },
              ),
            // Right drawer
            if (widget.rightDrawer != null)
              AnimatedBuilder(
                animation: _rightController,
                builder: (context, child) {
                  return Positioned(
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(
                        widget.drawerWidth * (1 - _rightController.value),
                        0,
                      ),
                      child: Opacity(
                        opacity: _rightController.value,
                        child: SafeArea(child: widget.rightDrawer!),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
