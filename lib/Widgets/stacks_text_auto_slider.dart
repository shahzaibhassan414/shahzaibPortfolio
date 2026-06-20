import 'package:flutter/material.dart';

import '../resource/appClass.dart';
import '../resource/colors.dart';

class StacksTextAutoSlider extends StatelessWidget {
  const StacksTextAutoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: AppClass()
          .skills
          .map(
            (skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors().cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors().dividerColor),
              ),
              child: Text(
                skill['name'],
                style: TextStyle(
                  color: AppColors().textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
