// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio/controller/generalController.dart';
// import 'package:portfolio/resource/appClass.dart';
// import 'package:portfolio/view/about/about.dart';
// import 'package:portfolio/view/experience/experience.dart';
// import 'package:portfolio/view/intro/intro.dart';
// import 'package:portfolio/view/skills/skills.dart';
// import 'package:portfolio/view/widget/appBar.dart';
// import 'package:portfolio/view/widget/leftPane.dart';
// import 'package:portfolio/view/widget/rightPane.dart';
// import 'package:portfolio/view/work/work.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';
//
// import 'contact/contact.dart';
//
// class RootScreen extends ConsumerStatefulWidget {
//   const RootScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<RootScreen> createState() => _RootScreenState();
// }
//
// class _RootScreenState extends ConsumerState<RootScreen>
//     with SingleTickerProviderStateMixin {
//   final mScrollController = AutoScrollController();
//
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//
//   bool _visible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//
//     _slideAnimation = Tween<Offset>(
//             begin: const Offset(0, -0.2), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//   }
//
//   void updateVisibility(bool visible) {
//     if (visible == _visible) return;
//     _visible = visible;
//     if (_visible) {
//       _controller.forward();
//     } else {
//       _controller.reverse();
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: NotificationListener<UserScrollNotification>(
//           onNotification: (notification) {
//             final ScrollDirection direction = notification.direction;
//             if (direction == ScrollDirection.reverse) {
//               ref.read(scrollControlProvider.notifier).state = false;
//             } else if (direction == ScrollDirection.forward) {
//               ref.read(scrollControlProvider.notifier).state = true;
//             }
//             return true;
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [
//                   Color(0xff112240),
//                   Color(0xff0a192f),
//                   Color(0xff020c1b)
//                 ])),
//             height: AppClass().getMqHeight(context),
//             child: Column(
//               children: [
//                 // Consumer(builder: (context, ref, child) {
//                 //   var isScrollingUp = ref.watch(scrollControlProvider);
//                 //   return AnimatedOpacity(
//                 //     opacity: isScrollingUp ? 1.0 : 0.0,
//                 //     duration: const Duration(milliseconds: 500),
//                 //     child: ActionBar(mScrollController),
//                 //   );
//                 // }),
//
//                 Consumer(builder: (context, ref, child) {
//                   final isScrollingUp = ref.watch(scrollControlProvider);
//                   updateVisibility(isScrollingUp);
//
//                   return SizeTransition(
//                     sizeFactor: _fadeAnimation,
//                     axisAlignment: -1.0,
//                     child: SlideTransition(
//                       position: _slideAnimation,
//                       child: ActionBar(mScrollController),
//                     ),
//                   );
//                 }),
//
//
//                 Expanded(
//                   child: () {
//                     ScreenType scrType = AppClass().getScreenType(context);
//                     return Row(
//                       children: [
//                         scrType == ScreenType.mobile ? SizedBox() : LeftPane(),
//                         Expanded(
//                             flex: 8,
//                             child: Consumer(builder: (context, ref, child) {
//                               bool scrollHandler =
//                                   ref.watch(scrollHandlerProvider);
//                               return ListView(
//                                 physics: scrollHandler
//                                     ? AlwaysScrollableScrollPhysics()
//                                     : NeverScrollableScrollPhysics(),
//                                 controller: mScrollController,
//                                 children: [
//                                   AutoScrollTag(
//                                       key: ValueKey(0),
//                                       controller: mScrollController,
//                                       index: 0,
//                                       child: IntroContent(mScrollController)),
//                                   AutoScrollTag(
//                                       key: ValueKey(1),
//                                       controller: mScrollController,
//                                       index: 1,
//                                       child: About()),
//                                   AutoScrollTag(
//                                       key: ValueKey(2),
//                                       controller: mScrollController,
//                                       index: 2,
//                                       child: Experience()),
//                                   AutoScrollTag(
//                                       key: ValueKey(3),
//                                       controller: mScrollController,
//                                       index: 3,
//                                       child: Skills()),
//                                   AutoScrollTag(
//                                       key: ValueKey(4),
//                                       controller: mScrollController,
//                                       index: 4,
//                                       child: Work()),
//                                   AutoScrollTag(
//                                       key: ValueKey(5),
//                                       controller: mScrollController,
//                                       index: 5,
//                                       child: Contact())
//                                 ],
//                               );
//                             })),
//                         scrType == ScreenType.mobile ? SizedBox() : RightPane(),
//                       ],
//                     );
//                   }(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/about/about.dart';
import 'package:portfolio/view/experience/experience.dart';
import 'package:portfolio/view/intro/intro.dart';
import 'package:portfolio/view/skills/skills.dart';
import 'package:portfolio/view/widget/appBar.dart';
import 'package:portfolio/view/widget/leftPane.dart';
import 'package:portfolio/view/widget/rightPane.dart';
import 'package:portfolio/view/work/work.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'contact/contact.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen>
    with TickerProviderStateMixin {
  final mScrollController = AutoScrollController(); // UNCHANGED

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void updateVisibility(bool visible) {
    if (visible == _visible) return;
    _visible = visible;
    _visible ? _controller.forward() : _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrType = AppClass().getScreenType(context); // ✅ ADDED
    final width = MediaQuery.of(context).size.width; // ✅ ADDED

    return SafeArea(
      child: Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              ref.read(scrollControlProvider.notifier).state = false;
            } else if (direction == ScrollDirection.forward) {
              ref.read(scrollControlProvider.notifier).state = true;
            }
            return true;
          },
          child: AnimatedBackground(
              behaviour: RandomParticleBehaviour(
                options: ParticleOptions(
                  baseColor: AppColors().primaryRedColor,
                  particleCount: 200
                )
              ),
              vsync: this,
            // decoration:  BoxDecoration(
            //   color: AppColors().blackColor,
            // ),
            child: Column(
              children: [
                /// ───── Animated AppBar ─────
                Consumer(builder: (context, ref, child) {
                  final isScrollingUp = ref.watch(scrollControlProvider);
                  updateVisibility(isScrollingUp);

                  return SizeTransition(
                    sizeFactor: _fadeAnimation,
                    axisAlignment: -1,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ActionBar(mScrollController),
                    ),
                  );
                }),

                /// ───── FULL PAGE SCROLL (FIXED) ─────
                Expanded(
                  child: Stack( // ✅ ADDED (critical)
                    children: [
                      /// MAIN SCROLLABLE CONTENT
                      SingleChildScrollView( // ✅ ADDED
                        controller: mScrollController,
                        child: Center( // ✅ ADDED (bounds width)
                          child: SizedBox(
                            width: scrType == ScreenType.mobile
                                ? width
                                : width * 0.8, // ✅ ADDED
                            child: Column( // ✅ ADDED
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
                                  child: Work(),
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

                      /// LEFT PANE (visual scroll)
                      if (scrType != ScreenType.mobile)
                         Positioned(
                          left: width * 0.05,
                          top: 0,
                          bottom: 0,
                          child: LeftPane(), // ✅ SAFE
                        ),

                      /// RIGHT PANE (visual scroll)
                      if (scrType != ScreenType.mobile)
                         Positioned(
                          right: width * 0.05,
                          top: 0,
                          bottom: 0,
                          child: RightPane(), // ✅ SAFE
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
