import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/custom_auto_slider.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/stacks_text_auto_slider.dart';
import '../../resource/appClass.dart';

class SkillsMobile extends ConsumerStatefulWidget {
  const SkillsMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<SkillsMobile> createState() => _ExperienceWebState();
}

class _ExperienceWebState extends ConsumerState<SkillsMobile> {
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
            title: "Skills",
            isWeb: false,
          ),
          const SizedBox(height: 30),
          Text(
            "Stacks",
            style: GoogleFonts.robotoSlab(
                color: Colors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(height: 20),
          const StacksTextAutoSlider(),
          const SizedBox(
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
          const SizedBox(
            height: 20,
          ),
          const SkillsAutoSlider(),
          SizedBox(height: AppClass().getMqWidth(context) * 0.1,)
        ],
      ),
    );
  }
}
