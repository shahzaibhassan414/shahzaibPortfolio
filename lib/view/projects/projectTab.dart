import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Widgets/main_title_widget.dart';
import '../../resource/colors.dart';
import 'Widgets/work_card.dart';

class ProjectTab extends ConsumerStatefulWidget {
  const ProjectTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ProjectTab> createState() => _WorkWebState();
}

class _WorkWebState extends ConsumerState<ProjectTab> {

  int? hoveredIndex;
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final allProjects = AppClass().projects;
    final displayedProjects = showAll ? allProjects : allProjects.take(3).toList();
    return Container(
      child: Column(
        children: [

          MainTitleWidget(
            title: "My Projects",
            isWeb: false,
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(displayedProjects.length, (index) {
                final project = displayedProjects[index];
                final bool isHovered = hoveredIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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


          if(!showAll)
            Center(
              child: InkWell(
                onTap: () {
                  setState(() => showAll = !showAll);
                },
                child: AnimatedRotation(
                  turns: showAll ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors().textColor,
                    size: 36,
                  ),
                ),
              ),
            ),
          SizedBox(height: AppClass().getMqHeight(context) * 0.15,)
        ],
      ),
    );
  }
}
