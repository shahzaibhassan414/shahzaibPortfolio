import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/view/work/Widgets/work_card.dart';
import '../../Widgets/main_title_widget.dart';
import '../../resource/colors.dart';

class WorkWeb extends ConsumerStatefulWidget {
  const WorkWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<WorkWeb> createState() => _WorkWebState();
}

class _WorkWebState extends ConsumerState<WorkWeb> {
  int? hoveredIndex;
  bool showAll = false;


  @override
  Widget build(BuildContext context) {
    final allProjects = AppClass().projects;
    final displayedProjects = showAll ? allProjects : allProjects.take(4).toList();


    return Container(
      margin: EdgeInsets.only(
          left: AppClass().getMqWidth(context) * 0.03,
          right: AppClass().getMqWidth(context) * 0.03),
      child: Column(
        children: [
          MainTitleWidget(
            number: "04",
            title: "My Projects",
          ),


          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.start,
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

          SizedBox(height: 20),


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
                  color: AppColors().primaryRedColor,
                  size: 36,
                ),
              ),
            ),
          ),



          SizedBox(height: AppClass().getMqWidth(context) * 0.1,)

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

  ProjectModel({required this.name, required this.image, this.description,
    this.iosLink, this.androidLink
  });
}
