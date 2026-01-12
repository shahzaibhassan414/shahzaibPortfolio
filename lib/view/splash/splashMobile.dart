import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../resource/colors.dart';
import '../root.dart';

class SplashMobile extends StatefulWidget {
  const SplashMobile({super.key});

  @override
  State<SplashMobile> createState() => _SplashMobileState();
}

class _SplashMobileState extends State<SplashMobile> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  double _loadingProgress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
    _startLoading();
  }

  void _startLoading() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      setState(() {
        if (_loadingProgress < 1.0) {
          _loadingProgress += 0.01;
        } else {
          _progressTimer?.cancel();
          _navigateToRoot();
        }
      });
    });
  }

  void _navigateToRoot() {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const RootScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1200),
      ),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff020c1b),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors().primaryRedColor.withOpacity(0.2),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors().primaryRedColor.withOpacity(0.1),
                            blurRadius: 30,
                            spreadRadius: 10,
                          )
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/svg/appLogo.png',
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            // Loading Bar
            Container(
              width: 250,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 250 * _loadingProgress,
                    decoration: BoxDecoration(
                      color: AppColors().primaryRedColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors().primaryRedColor.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "INITIALIZING EXPERIENCE...",
              style: TextStyle(
                color: AppColors().textColor.withOpacity(0.4),
                fontFamily: 'sfmono',
                fontSize: 10,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
