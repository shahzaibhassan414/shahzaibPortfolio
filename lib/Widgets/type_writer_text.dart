import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resource/colors.dart';
import '../resource/strings.dart';

class TypeWriterText extends StatefulWidget {
  final String text;
  final double? fontSize;
  const TypeWriterText({super.key, required this.text, this.fontSize});

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<int> _charCount;

   String _text = "";

  @override
  void initState() {
    super.initState();
    _text = widget.text;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _text.length * 80),
    );

    _charCount = StepTween(
      begin: 0,
      end: _text.length,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charCount,
      builder: (context, child) {
        return Text(
          _text.substring(0, _charCount.value),
          style: GoogleFonts.robotoSlab(
            color: AppColors().textLight,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            fontSize: widget.fontSize ?? 45,
          ),
        );
      },
    );
  }
}


