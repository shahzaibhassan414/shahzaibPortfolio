import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resource/colors.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "SH",
        style: GoogleFonts.poppins(
          color: AppColors().textColor,
          letterSpacing: 2,
          fontWeight: FontWeight.w800,
          fontSize:
          // isMobile ? 24 :
          35,
        ),
        children: [
          TextSpan(
            text: ".",
            style: GoogleFonts.poppins(
              color: AppColors().primaryRedColor,
              fontWeight: FontWeight.w900,
              fontSize:
              // isMobile ? 32 :
              48,
            ),
          ),
        ],
      ),
    );
  }
}
