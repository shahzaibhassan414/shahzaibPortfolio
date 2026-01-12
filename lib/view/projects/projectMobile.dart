import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/appClass.dart';
import '../../Widgets/main_title_widget.dart';
import '../../resource/colors.dart';
import 'Widgets/work_card.dart';

class ProjectMobile extends ConsumerStatefulWidget {
  const ProjectMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ProjectMobile> createState() => _WorkWebState();
}

class _WorkWebState extends ConsumerState<ProjectMobile> {
  int? hoveredIndex;
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final allProjects = AppClass().projects;
    final displayedProjects = showAll ? allProjects : allProjects.take(3).toList();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          MainTitleWidget(
            title: "My Projects",
            isWeb: false,
          ),
          const SizedBox(height: 20),

          AnimatedSize(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutQuart,
            child: Column(
              children: List.generate(displayedProjects.length, (index) {
                final project = displayedProjects[index];
                final bool isHovered = hoveredIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: WorkCard(
                    isHovered: isHovered,
                    project: project,
                    onEnter: (event) => setState(() => hoveredIndex = index),
                    onExit: (event) => setState(() => hoveredIndex = null),
                  ),
                );
              }),
            ),
          ),

          if(!showAll && allProjects.length > 3)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    setState(() => showAll = true);
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors().primaryRedColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "SHOW MORE",
                          style: TextStyle(
                            color: AppColors().primaryRedColor,
                            fontFamily: 'sfmono',
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors().primaryRedColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: AppClass().getMqHeight(context) * 0.1)
        ],
      ),
    );
  }
}
