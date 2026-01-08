import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  final bool isWeb;
  const MainTitleWidget(
      {super.key,
      required this.title,
      this.isWeb = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: AppClass().getMqHeight(context) * 0.07,
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.robotoSlab(
                color: AppColors().textColor,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: isWeb ? 40 : 25),
          ),
        ));
  }
}
