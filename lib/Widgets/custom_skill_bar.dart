import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../resource/appClass.dart';
import '../resource/colors.dart';

class CustomSkillBar extends StatelessWidget {
  final String skillName;
  final double value;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final bool isHovered;
  const CustomSkillBar({
    super.key,
    required this.skillName,
    required this.value, this.onEnter, this.onExit, required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final width = AppClass().getMqWidth(context) * 0.35;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: MouseRegion(
        onEnter: onEnter,
        onExit: onExit,
        child: SizedBox(
          width: width,
          child: AnimatedScale(
            scale: isHovered ? 1.03 : 1,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        skillName,
                        style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "${(value * 100).toInt()}%",
                        style: TextStyle(
                            color: AppColors().primaryRedColor,
                            fontSize: 20,
                            fontFamily: 'sfmono'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                LinearPercentIndicator(
                  width: width,
                  lineHeight: 10.0,
                  percent: value,
                  barRadius: Radius.circular(100),
                  backgroundColor: AppColors().textLight,
                  linearGradient: LinearGradient(
                    colors: [
                      AppColors().cardColor,
                      AppColors().primaryRedColor,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
