import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resource/colors.dart';

class CustomSkillImageCard extends StatelessWidget {
  final Map<String, dynamic> skill;
  final bool isHovered;
  final bool isWeb;

  const CustomSkillImageCard({
    super.key,
    required this.skill,
    required this.isHovered,
    required this.isWeb,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      width: isWeb ? 130 : 100,
      padding: EdgeInsets.all(isWeb ? 15 : 10),
      decoration: BoxDecoration(
        color: isHovered
            ? AppColors().primaryRedColor.withOpacity(0.12)
            : Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHovered
              ? AppColors().primaryRedColor.withOpacity(0.4)
              : Colors.white.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: [
          if (isHovered)
            BoxShadow(
              color: AppColors().primaryRedColor.withOpacity(0.15),
              blurRadius: 25,
              spreadRadius: 5,
            )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isHovered
                  ? Colors.white.withOpacity(0.08)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: AnimatedScale(
              scale: isHovered ? 1.2 : 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: isHovered ? 1.0 : 0.6,
                child: ColorFiltered(
                  colorFilter: isHovered
                      ? const ColorFilter.mode(
                          Colors.transparent, BlendMode.multiply)
                      : const ColorFilter.matrix(<double>[
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0, 0, 0, 1, 0,
                        ]),
                  child: Image.asset(
                    skill['image'],
                    height: isWeb ? 70 : 30,
                    width: isWeb ? 70 : 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: isWeb ? 15 : 5),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 400),
            style: GoogleFonts.robotoSlab(
              color: isHovered ? Colors.white : AppColors().textLight,
              letterSpacing: 1.5,
              fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
              fontSize: 12,
            ),
            child: Text(
              skill['name'],
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
