import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class MainTitleWidget extends StatefulWidget {
  final String title;
  final bool isWeb;
  const MainTitleWidget(
      {super.key,
      required this.title,
      this.isWeb = true});

  @override
  State<MainTitleWidget> createState() => _MainTitleWidgetState();
}

class _MainTitleWidgetState extends State<MainTitleWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppClass().getMqHeight(context) * 0.07,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                  color: AppColors().textColor,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.isWeb ? 40 : 28),
            ),
            const SizedBox(width: 8),
            Container(
              width: widget.isWeb ? 12 : 8,
              height: widget.isWeb ? 12 : 8,
              decoration: BoxDecoration(
                color: AppColors().primaryRedColor,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
