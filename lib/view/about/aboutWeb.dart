import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../Widgets/main_title_widget.dart';
import '../../controller/generalController.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';
import 'Widgets/animated_tech_items.dart';

class AboutWeb extends ConsumerStatefulWidget {
  const AboutWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<AboutWeb> createState() => _AboutWebState();
}

class _AboutWebState extends ConsumerState<AboutWeb> {
  final Set<int> _triggeredIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: AppClass().getMqWidth(context) * 0.03,
          right: AppClass().getMqWidth(context) * 0.03),
      padding: EdgeInsets.only(bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainTitleWidget(
            number: "01",
            title: "About Me",
          ),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        Strings.aboutPara1,
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          letterSpacing: 1,
                          height: 1.5,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        Strings.aboutPara2,
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          letterSpacing: 1,
                          height: 1.5,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        Strings.aboutPara3,
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          letterSpacing: 1,
                          height: 1.5,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        Strings.techIntro,
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          letterSpacing: 1,
                          height: 1.5,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 10,
                        ),
                        itemCount: Strings.techs.length,
                        itemBuilder: (context, index) {
                          return VisibilityDetector(
                            key: Key('tech_${index}'),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0.1) {
                                if (mounted) {
                                  setState(() {
                                    _triggeredIndexes.add(index);
                                  });
                                }
                              }
                            },
                            child: AnimatedTechItem(
                              text: Strings.techs[index],
                              delay: Duration(milliseconds: 100 * index),
                              animate: _triggeredIndexes.contains(index),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [

                      Consumer(builder: (context, ref, child) {
                        var data = ref.watch(hoverProvider);
                        bool isHovered = (data == "profilePic");
                        return Stack(
                          children: [
                            Container(
                              width: AppClass().getMqWidth(context) *
                                  (isHovered ? 0.22 : 0.225),
                              height: AppClass().getMqWidth(context) *
                                  (isHovered ? 0.24 : 0.243),
                              margin: EdgeInsets.only(top: 10, left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(
                                      color: AppColors().neonColor,
                                      width: 1.5)),
                            ),
                            InkWell(
                              onTap: () {},
                              onHover: (bol) {
                                if (bol) {
                                  ref.read(hoverProvider.notifier).state =
                                  "profilePic";
                                } else {
                                  ref.read(hoverProvider.notifier).state = "";
                                }
                              },
                              child: Container(
                                width: AppClass().getMqWidth(context) * 0.22,
                                height: AppClass().getMqWidth(context) * 0.24,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            AppColors().primaryColor,
                                            isHovered
                                                ? BlendMode.lighten
                                                : BlendMode.color),
                                        image: AssetImage(
                                            'assets/svg/profilePic.png')),
                                    color: Colors.transparent),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
