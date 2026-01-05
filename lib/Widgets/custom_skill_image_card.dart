import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resource/colors.dart';

class CustomSkillImageCard extends StatelessWidget {
  final Map<String, dynamic> skill;
  final bool isHovered;
  const CustomSkillImageCard({
    super.key,
    required this.skill, required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        // color: AppColors().textColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AnimatedScale(
              scale: isHovered ? 1.1 : 1,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              child: AnimatedOpacity(
                opacity:
                // isHovered ?
                1 ,
                    // :
                // 0.55,
                duration: const Duration(milliseconds: 200),
                child: ColorFiltered( // ADDED
                  colorFilter: ColorFilter.mode( // ADDED
                    AppColors().primaryColor, // ADDED
                    isHovered ?
                      BlendMode.lighten
                      :
                      BlendMode.color, // ADDED
                  ), // ADDED
                  child: Image.asset(
                    skill['image'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.scaleDown,
                  ),
                ),

              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Text(
            skill['name'],
            style: GoogleFonts.robotoSlab(
                color: Colors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
