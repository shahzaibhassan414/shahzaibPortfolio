import 'package:flutter/material.dart';

import '../../Widgets/about_stats_widget.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/recruiter_about_widgets.dart';
import '../../resource/appClass.dart';

class AboutWeb extends StatelessWidget {
  final VoidCallback onViewProjects;

  const AboutWeb({
    super.key,
    required this.onViewProjects,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: AppClass().getMqWidth(context) * 0.03,
        right: AppClass().getMqWidth(context) * 0.03,
        top: AppClass().getMqWidth(context) * 0.1,
      ),
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          const MainTitleWidget(title: 'About Me'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RecruiterAboutCopy(),
                    const SizedBox(height: 30),
                    AboutActionButtons(onViewProjects: onViewProjects),
                  ],
                ),
              ),
              const SizedBox(width: 64),
              const Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RecruiterProfileCard(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 52),
          const AboutStatsWidget(),
        ],
      ),
    );
  }
}
