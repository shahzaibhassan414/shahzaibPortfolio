import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/appClass.dart';
import '../../Widgets/main_title_widget.dart';
import '../../resource/colors.dart';
import 'Widgets/work_card.dart';

class ProjectWeb extends ConsumerStatefulWidget {
  const ProjectWeb({super.key});

  @override
  ConsumerState<ProjectWeb> createState() => _WorkWebState();
}

class _WorkWebState extends ConsumerState<ProjectWeb> with TickerProviderStateMixin {
  int? hoveredIndex;
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final allProjects = AppClass().projects;
    final displayedProjects = showAll ? allProjects : allProjects.take(4).toList();

    return Container(
      margin: EdgeInsets.only(
        left: AppClass().getMqWidth(context) * 0.03,
        right: AppClass().getMqWidth(context) * 0.03,
        top: AppClass().getMqWidth(context) * 0.1,
      ),
      // EdgeInsets.symmetric(
      //     horizontal: AppClass().getMqWidth(context) * 0.03),
      child: Column(
        children: [
          const MainTitleWidget(
            title: 'My Projects',
          ),
          const SizedBox(height: 30),

          AnimatedSize(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutQuart,
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: List.generate(displayedProjects.length, (index) {
                final project = displayedProjects[index];
                final bool isHovered = hoveredIndex == index;

                return WorkCard(
                  isHovered: isHovered,
                  project: project,
                  onEnter: (event) => setState(() => hoveredIndex = index),
                  onExit: (event) => setState(() => hoveredIndex = null),
                );
              }),
            ),
          ),

          const SizedBox(height: 50),

          if(!showAll && allProjects.length > 4)
          Center(
            child: InkWell(
              mouseCursor: SystemMouseCursors.none,
              onTap: () {
                setState(() => showAll = true);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors().primaryRedColor.withValues(alpha: 0.5)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SHOW MORE',
                      style: TextStyle(
                        color: AppColors().primaryRedColor,
                        fontFamily: 'sfmono',
                        fontSize: 14,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors().primaryRedColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          

        ],
      ),
    );
  }
}

class ProjectModel {
  String name;
  String image;
  String? description;
  String? iosLink;
  String? androidLink;
  List<String>? techs;

  ProjectModel({required this.name, required this.image, this.description,
    this.iosLink, this.androidLink, this.techs
  });
}
