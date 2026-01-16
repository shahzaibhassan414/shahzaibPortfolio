import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resource/colors.dart';

class CustomSkillImageCard extends StatelessWidget {
  final Map<String, dynamic> skill;
  final bool isHovered;

  const CustomSkillImageCard({
    super.key,
    required this.skill,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 130,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isHovered
            ? AppColors().primaryRedColor.withValues(alpha: 0.08)
            : Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHovered
              ? AppColors().primaryRedColor.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          if (isHovered)
            BoxShadow(
              color: AppColors().primaryRedColor.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 2,
            )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isHovered
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: AnimatedScale(
              scale: isHovered ? 1.15 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: ColorFiltered(
                colorFilter: isHovered
                    ? const ColorFilter.mode(
                        Colors.transparent, BlendMode.multiply)
                    : const ColorFilter.matrix(<double>[
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                      ]),
                child: Image.asset(
                  skill['image'],
                  height: 70,
                  width: 70,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            skill['name'],
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoSlab(
              color: isHovered ? AppColors().textColor : AppColors().textLight,
              letterSpacing: 1,
              fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
