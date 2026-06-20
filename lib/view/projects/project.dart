import 'package:flutter/material.dart';

import '../../Widgets/main_title_widget.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import 'Widgets/work_card.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;
    final projects = _showAll
        ? AppClass().projects
        : AppClass().projects.take(isWeb ? 6 : 4).toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 130 : 90,
        horizontal,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: 'My Projects', isWeb: isWeb),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 690),
            child: Text(
              'Selected mobile products spanning subscriptions, maps, real-time systems, payments, social platforms, and Web3.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 980
                  ? 3
                  : constraints.maxWidth >= 620
                      ? 2
                      : 1;
              const gap = 18.0;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: projects
                    .map(
                      (project) => SizedBox(
                        width: width,
                        child: WorkCard(project: project),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          if (!_showAll && projects.length < AppClass().projects.length) ...[
            const SizedBox(height: 32),
            Center(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _showAll = true),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('SHOW ALL PROJECTS'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors().primaryColor,
                  side: BorderSide(color: AppColors().dividerColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  textStyle: const TextStyle(
                    fontFamily: 'sfmono',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
