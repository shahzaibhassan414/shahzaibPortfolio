import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ActionBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final AutoScrollController controller;

  const ActionBar(this.controller, {super.key});

  @override
  ConsumerState<ActionBar> createState() => _ActionBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ActionBarState extends ConsumerState<ActionBar> {
  final double appBarHeight = 100.0;

  Widget logo(bool isMobile) {
    return InkWell(
      mouseCursor: SystemMouseCursors.none,
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            height: appBarHeight,
            decoration: BoxDecoration(
              color: const Color(0xff020c1b).withValues(alpha: 0.7),
            ),
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
                          _navItem("About", 1, "aboutTitle"),
                          _navItem("Experience", 2, "expTitle"),
                          _navItem("Skills", 3, "skillsTitle"),
                          _navItem("Packages", 4, "packages"),
                          _navItem("Projects", 5, "projects"),
                          _navItem("Blogs", 6, "blogs"),
                          _navItem("Contact", 7, "contactTitle"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }()),
      ),
    );
  }

  Widget _navItem(String title, int index, String hoverKey) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: InkWell(
        mouseCursor: SystemMouseCursors.none,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          widget.controller.scrollToIndex(index,
              preferPosition: AutoScrollPosition.begin);
        },
        onHover: (bol) {
          if (bol) {
            ref.read(hoverProvider.notifier).state = hoverKey;
          } else {
            ref.read(hoverProvider.notifier).state = "";
          }
        },
        child: Consumer(builder: (context, ref, child) {
          String state = ref.watch(hoverProvider);
          bool isHovered = (state == hoverKey);
          return Text(title,
              style: TextStyle(
                  color: isHovered
                      ? AppColors().primaryRedColor
                      : AppColors().textColor,
                  fontSize: 13,
                  fontFamily: 'sfmono'));
        }),
      ),
    );
  }
}
