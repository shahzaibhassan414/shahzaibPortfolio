import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/appClass.dart';
import '../../Widgets/experience_timeline_widget.dart';
import '../../Widgets/main_title_widget.dart';
import '../../model/experienceModel.dart';
import '../../resource/strings.dart';

class ExperienceWeb extends ConsumerStatefulWidget {
  const ExperienceWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<ExperienceWeb> createState() => _ExperienceWebState();
}

class _ExperienceWebState extends ConsumerState<ExperienceWeb> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  List<ExperienceWebModel> experienceList = [
    ExperienceWebModel(
      desig: Strings.expDesig2,
      compName: Strings.expCompName2,
      duration: Strings.expDur2,
      points: [
        Strings.expAbout2,
        Strings.expAbout2_2,
        Strings.expAbout2_3,
        Strings.expAbout2_4,
        Strings.expAbout2_5,
        Strings.expAbout2_6,
        Strings.expAbout2_7,
        Strings.expAbout2_8,
      ],
    ),
    ExperienceWebModel(
      desig: Strings.expDesig1,
      compName: Strings.expCompName1,
      duration: Strings.expDur1,
      points: [
        Strings.expAbout1,
        Strings.expAbout1_2,
        Strings.expAbout1_3,
        Strings.expAbout1_4,
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mqWidth = AppClass().getMqWidth(context);

    return Container(
      width: mqWidth,
      margin: EdgeInsets.symmetric(horizontal: mqWidth * 0.03),
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitleWidget(title: 'Experiences'),
          const SizedBox(height: 50),
          FadeTransition(
            opacity: _fadeAnimation,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experienceList.length,
              itemBuilder: (context, index) {
                return ExperienceTimelineWidget(
                  experience: experienceList[index],
                  isLast: index == experienceList.length - 1,
                  isFirst: index == 0,
                );
              },
            ),
          ),
          SizedBox(height: mqWidth * 0.1),
        ],
      ),
    );
  }
}
