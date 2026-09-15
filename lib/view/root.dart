import 'package:flutter/material.dart';
import 'package:portfolio/Widgets/scroll_reveal.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/view/about/about.dart';
import 'package:portfolio/view/blogs/blogs.dart';
import 'package:portfolio/view/contact/contact.dart';
import 'package:portfolio/view/experience/experience.dart';
import 'package:portfolio/view/intro/intro.dart';
import 'package:portfolio/view/packages/packages.dart';
import 'package:portfolio/view/projects/project.dart';
import 'package:portfolio/view/services/services.dart';
import 'package:portfolio/view/skills/skills.dart';
import 'package:portfolio/view/testimonials/testimonials.dart';
import 'package:portfolio/view/widget/appBar.dart';
import 'package:portfolio/view/widget/floating_quick_dock.dart';
import 'package:portfolio/view/widget/footer.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../resource/colors.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final mScrollController = AutoScrollController();

  static const _sections = <({String label, int index})>[
    (label: 'About', index: 1),
    (label: 'Services', index: 2),
    (label: 'Projects', index: 3),
    (label: 'Experience', index: 4),
    (label: 'Skills', index: 5),
    (label: 'Reviews', index: 6),
    (label: 'Contributions', index: 7),
    (label: 'Blogs', index: 8),
    (label: 'Contact', index: 9),
  ];

  @override
  void dispose() {
    mScrollController.dispose();
    super.dispose();
  }

  void _scrollTo(int index) {
    mScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
      duration: const Duration(milliseconds: 650),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width,
      backgroundColor: AppColors().backgroundColor,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SH.',
                    style: TextStyle(
                      color: AppColors().textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              ..._sections.map(
                (section) => InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _scrollTo(section.index);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors().dividerColor),
                      ),
                    ),
                    child: Text(
                      section.label,
                      style: TextStyle(
                        color: AppColors().textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => AppClass().downloadResume(context),
                  icon: const Icon(Icons.description_outlined, size: 18),
                  label: const Text('Open Resume'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    foregroundColor: AppColors().backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    textStyle: const TextStyle(
                      fontFamily: 'sfmono',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isCompact = screenType != ScreenType.web;
    final horizontalPadding = screenType == ScreenType.mobile ? 0.0 : 24.0;
    final topPadding = screenType == ScreenType.mobile ? 78.0 : 92.0;

    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      endDrawer: isCompact ? _buildMobileDrawer(context) : null,
      body: Stack(
        children: [
          const Positioned.fill(child: RepaintBoundary(child: _PageBackground())),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: mScrollController,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  topPadding,
                  horizontalPadding,
                  0,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1240),
                    child: Column(
                      children: [
                        _tag(0, IntroContent(mScrollController)),
                        _tag(
                          1,
                          About(onViewProjects: () => _scrollTo(3)),
                        ),
                        _tag(
                          2,
                          Services(onStartProject: () => _scrollTo(9)),
                        ),
                        _tag(3, const Projects()),
                        _tag(4, const Experience()),
                        _tag(5, const Skills()),
                        _tag(6, const Testimonials()),
                        _tag(7, const Packages()),
                        _tag(8, const Blogs()),
                        _tag(9, const Contact()),
                        ScrollReveal(
                          slideOffset: 24,
                          child: Footer(onBackToTop: () => _scrollTo(0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ActionBar(mScrollController),
          ),
          FloatingQuickDock(
            onStartProject: () => _scrollTo(9),
          ),
        ],
      ),
    );
  }

  Widget _tag(int index, Widget child) {
    final content = index == 0
        ? child
        : ScrollReveal(
            key: ValueKey('sec_reveal_$index'),
            slideOffset: 32.0,
            duration: const Duration(milliseconds: 600),
            child: child,
          );

    return AutoScrollTag(
      key: ValueKey(index),
      controller: mScrollController,
      index: index,
      child: RepaintBoundary(child: content),
    );
  }
}

class _PageBackground extends StatelessWidget {
  const _PageBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors().backgroundColor,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff091117),
                Color(0xff0B171C),
                Color(0xff091117),
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.85, -0.8),
              radius: 1.05,
              colors: [
                const Color(0xff2C7465).withValues(alpha: 0.28),
                Colors.transparent,
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.95, 0.85),
              radius: 1.15,
              colors: [
                const Color(0xff173E5B).withValues(alpha: 0.16),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const CustomPaint(painter: _GridPainter()),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0DC7D8DA)
      ..strokeWidth = 1;

    const gap = 64.0;
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
