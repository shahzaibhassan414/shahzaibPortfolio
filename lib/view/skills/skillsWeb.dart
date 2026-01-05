import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/custom_auto_slider.dart';
import '../../Widgets/custom_skill_bar.dart';
import '../../Widgets/main_title_widget.dart';
import '../../resource/appClass.dart';

class SkillsWeb extends ConsumerStatefulWidget {
  const SkillsWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<SkillsWeb> createState() => _ExperienceWebState();
}

class _ExperienceWebState extends ConsumerState<SkillsWeb> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final mqWidth = AppClass().getMqWidth(context);

    return Container(
      width: mqWidth,
      margin: EdgeInsets.symmetric(
        horizontal: mqWidth * 0.03,
      ),
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(
            number: "03",
            title: "Skills",
          ),
          Wrap(
            spacing: 40,
            alignment: WrapAlignment.spaceBetween,
            children: AppClass().skills.asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;
              final bool isHovered = hoveredIndex == index;
              return CustomSkillBar(
                skillName: skill["name"],
                value: skill["value"],
                isHovered: isHovered,
                onEnter: (event) => setState(() => hoveredIndex = index),
                onExit: (event) => setState(() => hoveredIndex = null),
              );
            }).toList(),
          ),

          SizedBox(
            height: 50,
          ),
          Text(
            'Tools & Technologies',
            style: GoogleFonts.robotoSlab(
                color: Colors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          SkillsAutoSlider(),
          SizedBox(height: AppClass().getMqWidth(context) * 0.1,)
        ],
      ),
    );
  }
}
