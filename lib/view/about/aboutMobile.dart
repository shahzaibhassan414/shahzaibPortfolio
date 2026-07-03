import 'package:flutter/material.dart';

import '../../Widgets/about_stats_widget.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/recruiter_about_widgets.dart';

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
            headlineSize: 27,
            compact: true,
          ),
          const SizedBox(height: 22),
          AboutActionButtons(
            onViewProjects: onViewProjects,
            centered: true,
          ),
          const SizedBox(height: 28),
          const RecruiterProfileCard(maxWidth: 330),
          const SizedBox(height: 28),
          const AboutStatsWidget(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
