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
    final double barWidth = isWeb ? mqWidth * 0.35 : isMobile ? mqWidth * 0.85 : mqWidth * 0.75;

    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: barWidth,
        decoration: BoxDecoration(
          color: isHovered ? Colors.white.withOpacity(0.03) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered ? AppColors().primaryRedColor.withOpacity(0.3) : Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: AppColors().primaryRedColor.withOpacity(0.05),
                blurRadius: 15,
                spreadRadius: 2,
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isHovered ? 12 : 0,
                      height: 2,
                      color: AppColors().primaryRedColor,
                      margin: EdgeInsets.only(right: isHovered ? 8 : 0),
                    ),
                    Text(
                      skillName,
                      style: GoogleFonts.robotoSlab(
                        color: isHovered ? AppColors().primaryRedColor : Colors.white,
                        letterSpacing: 1,
                        fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
                        fontSize: isWeb ? 17 : 15,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${(value * 100).toInt()}%",
                  style: TextStyle(
                    color: isHovered ? Colors.white : AppColors().primaryRedColor,
                    fontSize: isWeb ? 14 : 12,
                    fontFamily: 'sfmono',
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Background Bar
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Progress Bar
                LinearPercentIndicator(
                  key: ValueKey(isHovered ? "$skillName-hovered" : "$skillName-normal"),
                  padding: EdgeInsets.zero,
                  lineHeight: 8.0,
                  percent: value,
                  animation: true,
                  animationDuration: 1000,
                  curve: Curves.easeOutQuart,
                  barRadius: const Radius.circular(10),
                  backgroundColor: Colors.transparent,
                  linearGradient: LinearGradient(
                    colors: [
                      AppColors().primaryRedColor.withOpacity(0.6),
                      AppColors().primaryRedColor,
                    ],
                  ),
                ),
                // Glow effect on thumb/end of progress
                if (isHovered)
                  Positioned(
                    left: (barWidth - 32) * value - 5,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors().primaryRedColor,
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
