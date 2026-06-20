import 'package:flutter/material.dart';

import '../../Widgets/custom_auto_slider.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/stacks_text_auto_slider.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class Skills extends StatelessWidget {
  const Skills({super.key});

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
        isWeb ? 50 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: 'Skills', isWeb: isWeb),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              'A practical toolkit for building, integrating, shipping, and maintaining real mobile products.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),
          _Label(text: 'CORE CAPABILITIES'),
          const SizedBox(height: 16),
          const StacksTextAutoSlider(),
          const SizedBox(height: 44),
          _Label(text: 'TOOLS & PLATFORMS'),
          const SizedBox(height: 16),
          const SkillsAutoSlider(),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors().primaryColor,
        fontFamily: 'sfmono',
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }
}
