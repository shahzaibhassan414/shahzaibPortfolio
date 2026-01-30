import 'package:flutter/material.dart';
import '../../resource/responsive.dart';
import 'packagesWeb.dart';
import 'packagesMobile.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      webView: const PackagesWeb(),
      tabView: const PackagesMobile(),
      mobileView: const PackagesMobile(),
    );
  }
}
