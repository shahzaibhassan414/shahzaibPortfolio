import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resource/colors.dart';

class AnimatedTechItem extends StatefulWidget {
  final String text;
  final Duration delay;
  final bool animate;

  const AnimatedTechItem(
      {super.key,
      required this.text,
      required this.delay,
      this.animate = false});

  @override
  State<AnimatedTechItem> createState() => _AnimatedTechItemState();
}

class _AnimatedTechItemState extends State<AnimatedTechItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    if (widget.animate) {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedTechItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      // ADDED: animate on visibility
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Row(
          children: [
            const Icon(Icons.arrow_right, size: 20),
            const SizedBox(width: 4),
            Text(
              widget.text,
              style: GoogleFonts.robotoFlex(
                color: AppColors().textLight,
                letterSpacing: 1,
                height: 1.5,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
