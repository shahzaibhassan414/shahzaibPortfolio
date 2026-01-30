import 'package:flutter/material.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/package_card.dart';
import '../../resource/appClass.dart';

class PackagesMobile extends StatelessWidget {
  const PackagesMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final packages = AppClass().packages;
    final mqWidth = AppClass().getMqWidth(context);

    return Container(
      width: mqWidth,
      margin: EdgeInsets.symmetric(horizontal: mqWidth * 0.05),
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitleWidget(
            title: "Open Source",
            isWeb: false,
          ),
          const SizedBox(height: 30),
          ...packages.map((pkg) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: double.infinity,
              height: 240,
              child: PackageCard(package: pkg),
            ),
          )).toList(),
        ],
      ),
    );
  }
}
