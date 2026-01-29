import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/resource/custom_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../projectWeb.dart';

class ProjectDetailDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailDialog({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWeb = AppClass().getScreenType(context) == ScreenType.web;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
          horizontal: isWeb ? width * 0.25 : 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().darkColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors().primaryRedColor.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Image
                Stack(
                  children: [
                    Image.asset(
                      project.image,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors().darkColor,
                              AppColors().darkColor.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: GoogleFonts.roboto(
                          color: AppColors().textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Tech Stack Chips
                      if (project.techs != null && project.techs!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.techs!.map((tech) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors().primaryRedColor.withOpacity(0.3)),
                                color: AppColors().primaryRedColor.withOpacity(0.1),
                              ),
                              child: Text(
                                tech,
                                style: GoogleFonts.roboto(
                                  color: AppColors().primaryRedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )).toList(),
                          ),
                        ),

                      Text(
                        project.description ?? "No description available for this project.",
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          if (project.androidLink != null)
                            _buildLinkButton(
                              context,
                              "Play Store",
                              Icons.play_arrow_rounded,
                              project.androidLink!,
                            ),
                          const SizedBox(width: 15),
                          if (project.iosLink != null)
                            _buildLinkButton(
                              context,
                              "App Store",
                              Icons.apple,
                              project.iosLink!,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLinkButton(BuildContext context, String title, IconData icon, String link) {
    return InkWell(
      onTap: () async {
        await launchUrl(Uri.parse(link));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors().primaryRedColor.withOpacity(0.5)),
          color: AppColors().primaryRedColor.withOpacity(0.05),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors().primaryRedColor, size: 20),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.roboto(
                color: AppColors().primaryRedColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
