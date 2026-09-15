import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A wrapper widget that gives desktop and web users buttery-smooth mouse wheel scrolling.
///
/// Traditional Flutter Web mouse scrolling jumps by discrete pixel notches without inertia.
/// This widget intercepts [PointerScrollEvent]s and smoothly animates the [ScrollController]
/// to the target offset using an easing curve.
class SmoothWebScroll extends StatefulWidget {
  final ScrollController controller;
  final Widget child;

  /// Multiplier applied to mouse scroll delta.
  final double scrollSpeed;

  /// Duration of the smooth scroll animation.
  final Duration animationDuration;

  /// Easing curve for the smooth animation.
  final Curve curve;

  const SmoothWebScroll({
    super.key,
    required this.controller,
    required this.child,
    this.scrollSpeed = 1.0,
    this.animationDuration = const Duration(milliseconds: 260),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<SmoothWebScroll> createState() => _SmoothWebScrollState();
}

class _SmoothWebScrollState extends State<SmoothWebScroll> {
  double _targetOffset = 0.0;
  bool _isAnimating = false;

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;

    // Register with pointerSignalResolver to prevent the default abrupt jumpTo()
    GestureBinding.instance.pointerSignalResolver.register(event, (event) {
      if (event is! PointerScrollEvent) return;
      _handleScroll(event.scrollDelta.dy);
    });
  }

  void _handleScroll(double delta) {
    if (!widget.controller.hasClients) return;

    final position = widget.controller.position;
    final maxExtent = position.maxScrollExtent;
    final minExtent = position.minScrollExtent;

    // High precision trackpad gestures typically produce small fractional deltas (< 8px).
    // Let them glide natively with minimal latency, while smoothing mouse wheel notches.
    final isWheelTick = delta.abs() >= 8.0;

    if (!isWheelTick) {
      // Trackpad or fine gesture: quick responsive update
      final newOffset = (position.pixels + delta * widget.scrollSpeed)
          .clamp(minExtent, maxExtent);
      _targetOffset = newOffset;
      widget.controller.jumpTo(newOffset);
      return;
    }

    // Accumulate target offset so fast repeated wheel notches accelerate smoothly
    final currentOffset = _isAnimating ? _targetOffset : position.pixels;
    _targetOffset = (currentOffset + delta * widget.scrollSpeed)
        .clamp(minExtent, maxExtent);

    // If already at boundary, don't trigger unnecessary animation
    if ((_targetOffset == minExtent && position.pixels == minExtent) ||
        (_targetOffset == maxExtent && position.pixels == maxExtent)) {
      return;
    }

    _isAnimating = true;
    widget.controller
        .animateTo(
          _targetOffset,
          duration: widget.animationDuration,
          curve: widget.curve,
        )
        .whenComplete(() {
          if (mounted) {
            _isAnimating = false;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: widget.child,
    );
  }
}
