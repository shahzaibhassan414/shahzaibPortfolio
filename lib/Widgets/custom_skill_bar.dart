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
    required this.value,
    this.onEnter,
    this.onExit,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWeb = AppClass().getScreenType(context) == ScreenType.web;
    final bool isMobile = AppClass().getScreenType(context) == ScreenType.mobile;
    final double mqWidth = AppClass().getMqWidth(context);
    final double barWidth = isWeb ? mqWidth * 0.35 : isMobile ?  mqWidth * 0.85 : mqWidth * 0.7;

    Widget skillContent = SizedBox(
      width: barWidth,
      child: AnimatedScale(
        scale: isHovered ? 1.03 : 1,
        curve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    skillName,
                    style: GoogleFonts.robotoSlab(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      fontSize: isWeb ? 18 : 16,
                    ),
                  ),
                  Text(
                    "${(value * 100).toInt()}%",
                    style: TextStyle(
                      color: AppColors().primaryRedColor,
                      fontSize: isWeb ? 18 : 16,
                      fontFamily: 'sfmono',
                    ),
                  )
                ],
              ),
            ),
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              width: barWidth,
              lineHeight: 8.0,
              percent: value,
              animation: true, // Smooth loading animation
              animationDuration: 1000,
              barRadius: const Radius.circular(10),
              backgroundColor: AppColors().textLight.withValues(alpha: 0.2),
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
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: MouseRegion(
        onEnter: onEnter,
        onExit: onExit,
        cursor: SystemMouseCursors.click,
        child: isWeb ? skillContent : Center(child: skillContent),
      ),
    );
  }
}