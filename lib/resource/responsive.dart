import 'package:flutter/material.dart';
import 'package:portfolio/resource/appClass.dart';

class Responsive extends StatelessWidget {
  final Widget mobileView;
  final Widget? tabView;
  final Widget webView;

  const Responsive({
    super.key,
    required this.mobileView,
    this.tabView,
    required this.webView,
  });

  @override
  Widget build(BuildContext context) {
    final scrType = AppClass().getScreenType(context);
    switch (scrType) {
      case ScreenType.mobile:
        return mobileView;
      case ScreenType.tab:
        return tabView ?? mobileView;
      case ScreenType.web:
        return webView;
    }
  }
}

