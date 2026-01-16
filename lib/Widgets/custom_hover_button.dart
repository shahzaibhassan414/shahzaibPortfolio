import 'package:flutter/material.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class CustomHoverButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final double? width;
  final double? height;
  const CustomHoverButton({super.key, required this.onTap, required this.text, this.width, this.height});

  @override
  State<CustomHoverButton> createState() => _CustomHoverButtonState();
}

class _CustomHoverButtonState extends State<CustomHoverButton> {

  bool isHovered = false;


  @override
  Widget build(BuildContext context) {
    final double btnWidth =
        widget.width ?? AppClass().getMqWidth(context) * 0.2;
    final double btnHeight =
        widget.height ?? AppClass().getMqHeight(context) * 0.09;
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        mouseCursor: SystemMouseCursors.none,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Container(
          height: btnHeight,
          width: btnWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors().primaryRedColor,
              width: 1.5,
            ),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                left: isHovered ? 0 : -btnWidth,
                top: 0,
                bottom: 0,
                width: btnWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors().primaryRedColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Center(
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    color: isHovered
                        ? AppColors().textColor
                        : AppColors().primaryRedColor,
                    fontSize: 13,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sfmono',
                  ),
                  child: Text(widget.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
