import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resource/colors.dart';

class CustomSkillBar extends StatelessWidget {
  final String skillName;
  final double value;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final bool isHovered;
  final bool isWeb;

  const CustomSkillBar({
    super.key,
    required this.skillName,
    required this.value,
    this.onEnter,
    this.onExit,
    required this.isHovered, required this.isWeb,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      cursor: SystemMouseCursors.none,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isHovered 
              ? AppColors().primaryColor.withValues(alpha: 0.1) 
              : AppColors().cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHovered 
                ? AppColors().primaryColor.withValues(alpha: 0.5) 
                : AppColors().primaryColor.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: AppColors().primaryColor.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
              )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bolt_rounded,
              size: isWeb ? 16 : 14,
              color: isHovered ? AppColors().primaryColor : AppColors().mutedTextColor,
            ),
            const SizedBox(width: 8),
            Text(
              skillName,
              style: GoogleFonts.roboto(
                color: isHovered ? Colors.white : AppColors().textColor,
                letterSpacing: 1,
                fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400,
                fontSize:isWeb ?  14 : 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
