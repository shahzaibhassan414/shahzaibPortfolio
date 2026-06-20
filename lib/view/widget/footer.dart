import 'package:flutter/material.dart';

import '../../Widgets/custom_social_icon.dart';
import '../../resource/colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 34),
      child: Column(
        children: [
          Divider(color: AppColors().dividerColor, height: 1),
          const SizedBox(height: 26),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24,
            runSpacing: 18,
            children: [
              Text(
                '© 2026 Shahzaib Hassan',
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontFamily: 'sfmono',
                  fontSize: 10,
                ),
              ),
              const SocialIcons(),
              Text(
                'BUILT WITH FLUTTER',
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontFamily: 'sfmono',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
