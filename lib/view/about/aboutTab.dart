import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/main_title_widget.dart';
import '../../controller/generalController.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      // padding: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainTitleWidget(
            title: "About Me",
            isWeb: false,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: Strings.about1,
                    style: GoogleFonts.roboto(
                      color: AppColors().textLight,
                      letterSpacing: 1,
                      height: 1.5,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: Strings.about2,
                          style: GoogleFonts.roboto(
                            color: AppColors().primaryRedColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about3,
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      )
                    ]),
              ),
              SizedBox(height: 15,),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: Strings.about4,
                    style: GoogleFonts.roboto(
                      color: AppColors().textLight,
                      letterSpacing: 1,
                      height: 1.5,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: Strings.about5,
                          style: GoogleFonts.roboto(
                            color: AppColors().primaryRedColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about6,
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about7,
                          style: GoogleFonts.roboto(
                            color: AppColors().primaryRedColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about8,
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about9,
                          style: GoogleFonts.roboto(
                            color: AppColors().primaryRedColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about10,
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                    ]),
              ),

              SizedBox(height: 15,),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: Strings.about11,
                    style: GoogleFonts.roboto(
                      color: AppColors().textLight,
                      letterSpacing: 1,
                      height: 1.5,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: Strings.about12,
                          style: GoogleFonts.roboto(
                            color: AppColors().primaryRedColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about13,
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about14,
                          style: GoogleFonts.roboto(
                            color: AppColors().primaryRedColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about15,
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about16,
                          style: GoogleFonts.roboto(
                            color: AppColors().primaryRedColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      ),
                      TextSpan(
                          text: Strings.about17,
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 18,
                          )
                      )
                    ]),
              ),
            ],
          ),

          SizedBox(height: AppClass().getMqHeight(context) * 0.05,),
          SizedBox(
            height: AppClass().getMqWidth(context) * 0.5,
            child: Column(
              children: [
                Consumer(builder: (context, ref, child) {
                  var data = ref.watch(hoverProvider);
                  bool isHovered = (data == "profilePic");
                  return Stack(
                    children: [
                      Container(
                        width: AppClass().getMqWidth(context) *
                            (isHovered ? 0.42 : 0.425),
                        height: AppClass().getMqWidth(context) *
                            (isHovered ? 0.44 : 0.443),
                        margin: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                                color: AppColors().primaryRedColor,
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
                          width: AppClass().getMqWidth(context) * 0.42,
                          height: AppClass().getMqWidth(context) * 0.44,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      AppColors().blackColor,
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
            ),
          ),
          SizedBox(height: AppClass().getMqHeight(context) * 0.15,)
        ],
      ),
    );
  }
}
