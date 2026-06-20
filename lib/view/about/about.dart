import 'package:flutter/material.dart';
import 'package:portfolio/resource/responsive.dart';
import 'package:portfolio/view/about/aboutWeb.dart';
import 'package:portfolio/view/about/aboutMobile.dart';
import 'package:portfolio/view/about/aboutTab.dart';

class About extends StatelessWidget {
  final VoidCallback onViewProjects;

  const About({
    super.key,
    required this.onViewProjects,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      webView: AboutWeb(onViewProjects: onViewProjects),
      tabView: AboutTab(onViewProjects: onViewProjects),
      mobileView: AboutMobile(onViewProjects: onViewProjects),
    );
  }
}
