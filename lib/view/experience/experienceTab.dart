import 'package:flutter/material.dart';
import '../../Widgets/experience_timeline_widget.dart';
import '../../Widgets/main_title_widget.dart';
import '../../model/experienceModel.dart';
import '../../resource/appClass.dart';
import '../../resource/strings.dart';

class ExperienceTab extends StatefulWidget {
  const ExperienceTab({Key? key}) : super(key: key);

  @override
  State<ExperienceTab> createState() => _ExperienceTabState();
}

class _ExperienceTabState extends State<ExperienceTab> {
  final List<ExperienceWebModel> experienceList = [
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
  Widget build(BuildContext context) {
    final mqWidth = AppClass().getMqWidth(context);

    return Container(
      width: mqWidth,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(
            title: "Experiences",
            isWeb: false,
          ),
          const SizedBox(height: 50),
          ListView.builder(
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
          SizedBox(height: AppClass().getMqHeight(context) * 0.15,)
        ],
      ),
    );
  }
}
