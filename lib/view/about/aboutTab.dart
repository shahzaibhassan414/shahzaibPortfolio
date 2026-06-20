import 'package:flutter/material.dart';

import '../../Widgets/about_stats_widget.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/recruiter_about_widgets.dart';
import '../../resource/appClass.dart';

class AboutTab extends StatelessWidget {
  final VoidCallback onViewProjects;

  const AboutTab({
    super.key,
    required this.onViewProjects,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const MainTitleWidget(title: 'About Me', isWeb: false),
          const RecruiterAboutCopy(
            centered: true,
            headlineSize: 36,
          ),
          const SizedBox(height: 30),
          AboutActionButtons(
            onViewProjects: onViewProjects,
            centered: true,
          ),
          const SizedBox(height: 42),
          const RecruiterProfileCard(maxWidth: 410),
          const SizedBox(height: 42),
          const AboutStatsWidget(),
          SizedBox(height: AppClass().getMqHeight(context) * 0.1),
        ],
      ),
    );
  }
}
