import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/root.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({super.key});

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _entrance;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1450),
    )..addStatusListener(_handleAnimationStatus);

    _entrance = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.38, curve: Curves.easeOutCubic),
    );
    _progress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.92, curve: Curves.easeInOutCubic),
    );

    _controller.forward();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, animation, secondaryAnimation) => const RootScreen(),
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 360),
      ),
    );
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_handleAnimationStatus)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final compact = MediaQuery.sizeOf(context).width < 600;
    final logoSize = compact ? 154.0 : 180.0;
    final progressWidth = compact ? 240.0 : 300.0;

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff071016),
                  Color(0xff0B1B20),
                  Color(0xff071016),
                ],
              ),
            ),
          ),
          CustomPaint(painter: _SplashGridPainter()),
          Positioned(
            top: -180,
            right: -120,
            child: _GlowOrb(
              size: compact ? 360 : 480,
              color: colors.primaryColor.withValues(alpha: 0.13),
            ),
          ),
          Positioned(
            bottom: -220,
            left: -160,
            child: _GlowOrb(
              size: compact ? 380 : 520,
              color: const Color(0xff2F82B8).withValues(alpha: 0.08),
            ),
          ),
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _entrance,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(_entrance),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return SizedBox.square(
                            dimension: logoSize,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Transform.rotate(
                                  angle: _controller.value * math.pi * 0.7,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colors.primaryColor.withValues(
                                          alpha: 0.14,
                                        ),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colors.primaryColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: colors.primaryColor
                                                  .withValues(alpha: 0.7),
                                              blurRadius: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: logoSize * 0.68,
                                  height: logoSize * 0.68,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(
                                      0xff101F26,
                                    ).withValues(alpha: 0.92),
                                    border: Border.all(
                                      color: colors.primaryColor.withValues(
                                        alpha: 0.28,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.primaryColor.withValues(
                                          alpha:
                                              0.08 + (_controller.value * 0.08),
                                        ),
                                        blurRadius: 42,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'SH',
                                      children: [
                                        TextSpan(
                                          text: '.',
                                          style: TextStyle(
                                            color: colors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: TextStyle(
                                      color: colors.textColor,
                                      fontSize: compact ? 31 : 36,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: compact ? 34 : 42),
                      Text(
                        'CRAFTING DIGITAL EXPERIENCES',
                        style: TextStyle(
                          color: colors.textColor.withValues(alpha: 0.82),
                          fontFamily: 'sfmono',
                          fontSize: compact ? 9 : 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: compact ? 2.1 : 3.2,
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: progressWidth,
                        height: 3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.textColor.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedBuilder(
                              animation: _progress,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  widthFactor: _progress.value,
                                  child: child,
                                );
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  gradient: LinearGradient(
                                    colors: [
                                      colors.primaryColor
                                          .withValues(alpha: 0.5),
                                      colors.primaryColor,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.primaryColor.withValues(
                                        alpha: 0.45,
                                      ),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      AnimatedBuilder(
                        animation: _progress,
                        builder: (context, child) {
                          return Text(
                            '${(_progress.value * 100).round().toString().padLeft(2, '0')}%',
                            style: TextStyle(
                              color: colors.mutedTextColor.withValues(
                                alpha: 0.72,
                              ),
                              fontFamily: 'sfmono',
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: compact ? 26 : 34,
            child: FadeTransition(
              opacity: _entrance,
              child: Text(
                'FLUTTER  •  MOBILE  •  WEB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.mutedTextColor.withValues(alpha: 0.38),
                  fontFamily: 'sfmono',
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

class _SplashGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff72E6BE).withValues(alpha: 0.025)
      ..strokeWidth = 1;
    const spacing = 52.0;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
