import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resource/colors.dart';

class MainTitleWidget extends StatelessWidget {
  final String number;
  final String title;
  const MainTitleWidget({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: "$number.",
                style: TextStyle(
                    color: AppColors().neonColor,
                    fontSize: 20,
                    fontFamily: 'sfmono'),
                children: <TextSpan>[
                  TextSpan(
                    text: ' $title',
                    style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )
                ]),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Divider(
              color: AppColors().textLight,
              thickness: 1,
            ),
          ),
          SizedBox(width: 20,)
        ],
      ),
    );
  }
}
