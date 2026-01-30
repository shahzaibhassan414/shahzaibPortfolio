import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/resource/responsive.dart';
import 'package:portfolio/view/projects/projectMobile.dart';
import 'package:portfolio/view/projects/projectTab.dart';
import 'package:portfolio/view/projects/projectWeb.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      tabView: const ProjectTab(),
      webView: const ProjectWeb(),
      mobileView: const ProjectMobile(),
    );
  }
}
