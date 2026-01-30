import 'package:flutter/material.dart';
import 'package:portfolio/resource/responsive.dart';
import 'package:portfolio/view/skills/skillsMobile.dart';
import 'package:portfolio/view/skills/skillsTab.dart';
import 'package:portfolio/view/skills/skillsWeb.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      webView: const SkillsWeb(),
      mobileView: const SkillsMobile(),
      tabView: const SkillsTab(),
    );
  }
}
