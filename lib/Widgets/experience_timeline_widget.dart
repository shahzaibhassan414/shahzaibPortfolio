import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/experienceModel.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class ExperienceTimelineWidget extends StatelessWidget {
  final ExperienceWebModel experience;
  final bool isLast;
  final bool isFirst;

  const ExperienceTimelineWidget({
    super.key,
    required this.experience,
    this.isLast = false,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppClass().getScreenType(context) == ScreenType.mobile;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors().primaryRedColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors().primaryRedColor.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors().primaryRedColor.withValues(alpha: 0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.duration,
                    style: TextStyle(
                      color: AppColors().primaryRedColor,
                      fontSize: 14,
                      fontFamily: 'sfmono',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    experience.desig,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    experience.compName,
                    style: GoogleFonts.roboto(
                      color: AppColors().textLight,
                      fontSize: isMobile ? 16 : 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...experience.points.map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(
                            Icons.arrow_right_rounded,
                            size: 20,
                            color: AppColors().primaryRedColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              color: AppColors().textLight.withValues(alpha: 0.8),
                              fontSize: 14,
                              height: 1.5,
                              fontFamily: 'sfmono',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
