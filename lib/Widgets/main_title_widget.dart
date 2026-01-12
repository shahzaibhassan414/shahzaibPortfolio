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
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
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
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
              padding: EdgeInsets.only(
                bottom: AppClass().getMqHeight(context) * 0.07,
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: GoogleFonts.robotoSlab(
                      color: AppColors().textColor,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.isWeb ? 40 : 25),
                ),
              )),
        ),
      ),
    );
  }
}
