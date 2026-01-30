import 'package:flutter/material.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/package_card.dart';
import '../../resource/appClass.dart';

class PackagesWeb extends StatelessWidget {
  const PackagesWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final packages = AppClass().packages;
    final mqWidth = AppClass().getMqWidth(context);

    return Container(
      width: mqWidth,
      margin: EdgeInsets.only(
        left: mqWidth * 0.03,
        right: mqWidth * 0.03,
        top: mqWidth * 0.1,
      ),
      // EdgeInsets.symmetric(horizontal: mqWidth * 0.03),
      // padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitleWidget(title: "Open Source Contributions"),
          const SizedBox(height: 40),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: packages.map((pkg) => SizedBox(
                height: 250,
                child: PackageCard(package: pkg),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
