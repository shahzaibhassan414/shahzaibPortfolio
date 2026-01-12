import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/resource/colors.dart';
import '../root.dart';

class SplashWeb extends StatefulWidget {
  const SplashWeb({super.key});

  @override
  State<SplashWeb> createState() => _SplashWebState();
}


class _SplashWebState extends State<SplashWeb>
    with SingleTickerProviderStateMixin {

  Timer? _timer;

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    _timer = Timer(const Duration(seconds: 4), () async {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RootScreen()),
            (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xff112240),
                Color(0xff0a192f),
                Color(0xff020c1b)
              ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    const Text(
                      'I BUILD',
                      style: TextStyle(
                        fontSize: 42.0,
                        fontWeight: FontWeight.w500,
                          fontFamily: 'sfmono'
                      ),
                    ),

                    const SizedBox(width: 15.0),

                    DefaultTextStyle(
                      style:  TextStyle(
                        fontSize: 44.0,
                        fontFamily: 'sfmono',
                        fontWeight: FontWeight.bold,
                        color: AppColors().primaryRedColor,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(milliseconds: 0),
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          RotateAnimatedText('EXPERIENCES'),
                          RotateAnimatedText('PRODUCTS'),
                          RotateAnimatedText('APPLICATIONS'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
