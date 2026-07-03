import 'package:flutter/material.dart';

import '../../Widgets/main_title_widget.dart';
import '../../Widgets/package_card.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final isMobile = screenType == ScreenType.mobile;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 130 : 56,
        horizontal,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(
            title: 'Open Source Contributions',
            isWeb: isWeb,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              'Small, reusable Flutter tools extracted from real UI problems and published for other developers.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 17 : 14,
                height: isMobile ? 1.48 : 1.6,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 24 : 36),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth >= 760
                  ? (constraints.maxWidth - 18) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: 18,
                runSpacing: 18,
                children: AppClass()
                    .packages
                    .map(
                      (package) => SizedBox(
                        width: width,
                        height: isMobile ? 214 : 250,
                        child: PackageCard(package: package),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
