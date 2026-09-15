import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A lightweight, high-performance scroll reveal widget.
///
/// Smoothly animates its child into view (fade + translateY) when it enters the viewport.
/// Once revealed, it never re-animates, ensuring zero runtime CPU/GPU overhead during scrolling.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double slideOffset;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.slideOffset = 30.0,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  bool _hasRevealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerReveal() {
    if (_hasRevealed) return;
    _hasRevealed = true;

    if (widget.delay == Duration.zero) {
      if (mounted) _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasRevealed && _controller.isCompleted) {
      return RepaintBoundary(child: widget.child);
    }

    return VisibilityDetector(
      key: ValueKey(hashCode),
      onVisibilityChanged: (info) {
        if (!_hasRevealed && info.visibleFraction >= 0.08) {
          _triggerReveal();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: _slide.value,
              child: child,
            ),
          );
        },
        child: RepaintBoundary(child: widget.child),
      ),
    );
  }
}
