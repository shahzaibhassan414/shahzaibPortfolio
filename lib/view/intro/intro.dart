import 'package:flutter/material.dart';
import 'package:portfolio/resource/responsive.dart';
import 'package:portfolio/view/intro/introMobile.dart';
import 'package:portfolio/view/intro/introWeb.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'introTab.dart';

class IntroContent extends StatelessWidget {
  final AutoScrollController aScrollController;

  const IntroContent(this.aScrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      tabView: IntroTab(aScrollController),
      mobileView: IntroMobile(aScrollController),
      webView: IntroWeb(aScrollController),
    );
  }
}
