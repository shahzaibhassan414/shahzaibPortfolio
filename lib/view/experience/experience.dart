import 'package:flutter/material.dart';

import '../../Widgets/experience_timeline_widget.dart';
import '../../Widgets/main_title_widget.dart';
import '../../model/experienceModel.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  static final _items = <ExperienceWebModel>[
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
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;

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
          MainTitleWidget(title: 'Experiences', isWeb: isWeb),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 670),
            child: Text(
              'A progression from hands-on app delivery to leading production Flutter work across complex integrations.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),
          ...List.generate(
            _items.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ExperienceTimelineWidget(
                experience: _items[index],
                isFirst: index == 0,
                isLast: index == _items.length - 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
