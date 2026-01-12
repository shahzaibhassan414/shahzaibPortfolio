import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class MainTitleWidget extends StatefulWidget {
  final String title;
  final bool isWeb;
  const MainTitleWidget(
      {super.key,
      required this.title,
      this.isWeb = true});

  @override
  State<MainTitleWidget> createState() => _MainTitleWidgetState();
}

class _MainTitleWidgetState extends State<MainTitleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(-0.1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.title),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          _isVisible = true;
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: AppClass().getMqHeight(context) * 0.07,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.poppins(
                              color: AppColors().textColor,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                              fontSize: widget.isWeb ? 40 : 28),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: widget.isWeb ? 12 : 8,
                          height: widget.isWeb ? 12 : 8,
                          decoration: BoxDecoration(
                            color: AppColors().primaryRedColor,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
