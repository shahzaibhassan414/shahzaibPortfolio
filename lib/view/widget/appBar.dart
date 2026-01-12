import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ActionBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final AutoScrollController controller;

  ActionBar(this.controller, {Key? key}) : super(key: key);

  @override
  ConsumerState<ActionBar> createState() => _ActionBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ActionBarState extends ConsumerState<ActionBar> {
  Widget logo(bool isMobile) {
    return InkWell(
      onTap: () {
        widget.controller.scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
      },
      onHover: (bol) {
        if (bol) {
          ref.read(hoverProvider.notifier).state = "logo";
        } else {
          ref.read(hoverProvider.notifier).state = "";
        }
      },
      child: Consumer(builder: (context, ref, child) {
        bool isHovered = ref.watch(hoverProvider) == "logo";
        return AnimatedScale(
          scale: isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: RichText(
            text: TextSpan(
              text: "SH",
              style: GoogleFonts.poppins(
                color: isHovered ? AppColors().primaryRedColor : AppColors().textColor,
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
                fontSize: isMobile ? 24 : 32,
              ),
              children: [
                TextSpan(
                  text: ".",
                  style: GoogleFonts.poppins(
                    color: isHovered ? AppColors().textColor : AppColors().primaryRedColor,
                    fontWeight: FontWeight.w900,
                    fontSize: isMobile ? 32 : 45,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        padding: const EdgeInsets.only(right: 15.0, top: 20.0),
        child: () {
          ScreenType scrType = AppClass().getScreenType(context);
          if (scrType == ScreenType.mobile || scrType == ScreenType.tab) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  logo(true),
                  IconButton(
                    icon: Icon(Icons.menu_rounded,
                        color: AppColors().primaryRedColor, size: 32),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  )
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Row(
              children: [
                logo(false),
                Expanded(
                  flex: 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            widget.controller.scrollToIndex(1,
                                preferPosition: AutoScrollPosition.begin);
                          },
                          onHover: (bol) {
                            if (bol) {
                              ref.read(hoverProvider.notifier).state =
                                  "aboutTitle";
                            } else {
                              ref.read(hoverProvider.notifier).state = "";
                            }
                          },
                          child: Consumer(builder: (context, ref, child) {
                            String state = ref.watch(hoverProvider);
                            bool isHovered = (state == "aboutTitle");
                            return Text("About",
                                style: TextStyle(
                                    color: isHovered
                                        ? AppColors().primaryRedColor
                                        : AppColors().textColor,
                                    fontSize: 13,
                                    fontFamily: 'sfmono'));
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            widget.controller.scrollToIndex(2,
                                preferPosition: AutoScrollPosition.begin);
                          },
                          onHover: (bol) {
                            if (bol) {
                              ref.read(hoverProvider.notifier).state =
                                  "expTitle";
                            } else {
                              ref.read(hoverProvider.notifier).state = "";
                            }
                          },
                          child: Consumer(builder: (context, ref, child) {
                            String state = ref.watch(hoverProvider);
                            bool isHovered = (state == "expTitle");
                            return Text("Experience",
                                style: TextStyle(
                                    color: isHovered
                                        ? AppColors().primaryRedColor
                                        : AppColors().textColor,
                                    fontSize: 13,
                                    fontFamily: 'sfmono'));
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            widget.controller.scrollToIndex(3,
                                preferPosition: AutoScrollPosition.begin);
                          },
                          onHover: (bol) {
                            if (bol) {
                              ref.read(hoverProvider.notifier).state =
                                  "skillsTitle";
                            } else {
                              ref.read(hoverProvider.notifier).state = "";
                            }
                          },
                          child: Consumer(builder: (context, ref, child) {
                            String state = ref.watch(hoverProvider);
                            bool isHovered = (state == "skillsTitle");

                            return Text("Skills",
                                style: TextStyle(
                                    color: isHovered
                                        ? AppColors().primaryRedColor
                                        : AppColors().textColor,
                                    fontSize: 13,
                                    fontFamily: 'sfmono'));
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            widget.controller.scrollToIndex(4,
                                preferPosition: AutoScrollPosition.begin);
                          },
                          onHover: (bol) {
                            if (bol) {
                              ref.read(hoverProvider.notifier).state =
                                  "workTitle";
                            } else {
                              ref.read(hoverProvider.notifier).state = "";
                            }
                          },
                          child: Consumer(builder: (context, ref, child) {
                            String state = ref.watch(hoverProvider);
                            bool isHovered = (state == "workTitle");

                            return Text("Projects",
                                style: TextStyle(
                                    color: isHovered
                                        ? AppColors().primaryRedColor
                                        : AppColors().textColor,
                                    fontSize: 13,
                                    fontFamily: 'sfmono'));
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            widget.controller.scrollToIndex(5,
                                preferPosition: AutoScrollPosition.begin);
                          },
                          onHover: (bol) {
                            if (bol) {
                              ref.read(hoverProvider.notifier).state =
                                  "contactTitle";
                            } else {
                              ref.read(hoverProvider.notifier).state = "";
                            }
                          },
                          child: Consumer(builder: (context, ref, child) {
                            String state = ref.watch(hoverProvider);
                            bool isHovered = (state == "contactTitle");
                            return Text(" Contact",
                                style: TextStyle(
                                    color: isHovered
                                        ? AppColors().primaryRedColor
                                        : AppColors().textColor,
                                    fontSize: 13));
                          }),
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        String state = ref.watch(hoverProvider);
                        bool isHovered = (state == "resume");
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            AppClass().downloadResume(context);
                          },
                          onHover: (bol) {
                            if (bol) {
                              ref.read(hoverProvider.notifier).state = "resume";
                            } else {
                              ref.read(hoverProvider.notifier).state = "";
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              color: isHovered
                                  ? AppColors().primaryRedColor
                                  : Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(
                                color: AppColors().primaryRedColor,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text('Resume',
                                  style: TextStyle(
                                      color: isHovered
                                          ? Colors.white
                                          : AppColors().primaryRedColor,
                                      fontSize: 13,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'sfmono')),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }());
  }

  mOnTab(int i) {
    widget.controller
        .scrollToIndex(i, preferPosition: AutoScrollPosition.begin);
  }
}
