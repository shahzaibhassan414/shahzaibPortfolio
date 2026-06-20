import 'package:flutter/material.dart';

import '../../Widgets/about_stats_widget.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/recruiter_about_widgets.dart';
import '../../resource/appClass.dart';

class AboutMobile extends StatelessWidget {
  final VoidCallback onViewProjects;

  const AboutMobile({
    super.key,
    required this.onViewProjects,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const MainTitleWidget(title: 'About Me', isWeb: false),
          const RecruiterAboutCopy(
            centered: true,
            headlineSize: 30,
          ),
          const SizedBox(height: 28),
          AboutActionButtons(
            onViewProjects: onViewProjects,
            centered: true,
          ),
          const SizedBox(height: 38),
          const RecruiterProfileCard(maxWidth: 360),
          const SizedBox(height: 38),
          const AboutStatsWidget(),
          SizedBox(height: AppClass().getMqHeight(context) * 0.1),
        ],
      ),
    );
  }
}
