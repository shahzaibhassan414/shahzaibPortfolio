import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/view/about/about.dart';
import 'package:portfolio/view/experience/experience.dart';
import 'package:portfolio/view/intro/intro.dart';
import 'package:portfolio/view/projects/project.dart';
import 'package:portfolio/view/skills/skills.dart';
import 'package:portfolio/view/widget/appBar.dart';
import 'package:portfolio/view/widget/leftPane.dart';
import 'package:portfolio/view/widget/rightPane.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../resource/colors.dart';
import 'contact/contact.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen>
    with TickerProviderStateMixin {
  final mScrollController = AutoScrollController();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  void updateVisibility(bool visible) {
    if (visible == _visible) return;
    _visible = visible;
    if (_visible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      width: double.infinity,
      backgroundColor: AppColors().cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors().textColor,
                      )),
                )),
            Image.asset('assets/svg/appLogo.png', height: 60),
            const SizedBox(height: 40),
            _drawerTile("About", 1),
            _drawerTile("Experience", 2),
            _drawerTile("Skills", 3),
            _drawerTile("Work", 4),
            _drawerTile("Contact", 5),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: OutlinedButton(
                onPressed: () => AppClass().downloadResume(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors().primaryRedColor),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Center(
                  child: Text("Resume",
                      style: TextStyle(
                          color: AppColors().primaryRedColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(String title, int index) {
    return ListTile(
      title: Text(title,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 18, letterSpacing: 1.2)),
      onTap: () {
        Navigator.pop(context);
        mScrollController.scrollToIndex(index,
            preferPosition: AutoScrollPosition.begin);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    mScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrType = AppClass().getScreenType(context);
    final width = MediaQuery.of(context).size.width;
    bool isMobile = scrType == ScreenType.mobile || scrType == ScreenType.tab;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff020c1b), // Modern Deep Navy
        endDrawer: isMobile ? _buildMobileDrawer(context) : null,
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.7, -0.4),
              radius: 1.5,
              colors: [
                AppColors().primaryRedColor.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
          ),
          child: AnimatedBackground(
            behaviour: RandomParticleBehaviour(
                options: ParticleOptions(
                    baseColor: AppColors().primaryRedColor, 
                    particleCount: 50,
                    // spawnMaxRadius: 1.5,
                    // spawnMinRadius: 0.5,
                    spawnMaxSpeed: 15,
                    spawnMinSpeed: 5,
                )),
            vsync: this,
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  ref.read(scrollControlProvider.notifier).state = false;
                } else if (direction == ScrollDirection.forward) {
                  ref.read(scrollControlProvider.notifier).state = true;
                }
                return true;
              },
              child: Column(
                children: [
                  Consumer(builder: (context, ref, child) {
                    final isScrollingUp = ref.watch(scrollControlProvider);
                    updateVisibility(isScrollingUp);

                    return SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: RepaintBoundary(child: ActionBar(mScrollController)),
                      ),
                    );
                  }),

                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: SingleChildScrollView(
                            controller: mScrollController,
                            physics: const BouncingScrollPhysics(),
                            child: Center(
                              child: SizedBox(
                                width: scrType == ScreenType.mobile
                                    ? width
                                    : width * 0.8,
                                child: RepaintBoundary(
                                  child: Column(
                                    children: [
                                      AutoScrollTag(
                                        key: const ValueKey(0),
                                        controller: mScrollController,
                                        index: 0,
                                        child: IntroContent(mScrollController),
                                      ),
                                      AutoScrollTag(
                                        key: const ValueKey(1),
                                        controller: mScrollController,
                                        index: 1,
                                        child: About(),
                                      ),
                                      AutoScrollTag(
                                        key: const ValueKey(2),
                                        controller: mScrollController,
                                        index: 2,
                                        child: Experience(),
                                      ),
                                      AutoScrollTag(
                                        key: const ValueKey(3),
                                        controller: mScrollController,
                                        index: 3,
                                        child: Skills(),
                                      ),
                                      AutoScrollTag(
                                        key: const ValueKey(4),
                                        controller: mScrollController,
                                        index: 4,
                                        child: Projects(),
                                      ),
                                      AutoScrollTag(
                                        key: const ValueKey(5),
                                        controller: mScrollController,
                                        index: 5,
                                        child: Contact(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (scrType != ScreenType.mobile)
                          Positioned(
                            left: width * 0.05,
                            top: 0,
                            bottom: 0,
                            child: RepaintBoundary(child: LeftPane()),
                          ),

                        if (scrType != ScreenType.mobile)
                          Positioned(
                            right: width * 0.05,
                            top: 0,
                            bottom: 0,
                            child: RepaintBoundary(child: RightPane()),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
