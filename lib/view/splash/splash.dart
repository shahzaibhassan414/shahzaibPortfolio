import 'package:flutter/material.dart';
import 'package:portfolio/resource/responsive.dart';
import 'package:portfolio/view/splash/splashMobile.dart';
import 'package:portfolio/view/splash/splashTab.dart';
import 'package:portfolio/view/splash/splashWeb.dart';

class SplashContent extends StatefulWidget {

  SplashContent({Key? key}) : super(key: key);

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      tabView: SplashTab(),
      mobileView: SplashMobile(),
      webView: SplashWeb(),
    );
  }
}
