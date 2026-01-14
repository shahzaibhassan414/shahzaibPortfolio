import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/about_stats_widget.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainTitleWidget(
            title: "About Me",
            isWeb: false,
          ),
          const SizedBox(height: 20),
          _ProfileImageTab(),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AboutText(),
              const SizedBox(height: 30),
              const AboutStatsWidget(),
            ],
          ),
          SizedBox(height: AppClass().getMqHeight(context) * 0.1)
        ],
      ),
    );
  }

  Widget _AboutText() {
    return Column(
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
        const SizedBox(height: 15,),
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
      ],
    );
  }

  Widget _ProfileImageTab() {
    return Consumer(builder: (context, ref, child) {
      var data = ref.watch(hoverProvider);
      bool isHovered = (data == "profilePic");
      return Stack(
        children: [
          Container(
            width: AppClass().getMqWidth(context) * 0.4,
            height: AppClass().getMqWidth(context) * 0.42,
            margin: const EdgeInsets.only(top: 10, left: 10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                    color: AppColors().primaryRedColor,
                    width: 1.5)),
          ),
          InkWell(
            onTap: () {},
            onHover: (bol) {
              if (bol) {
                ref.read(hoverProvider.notifier).state = "profilePic";
              } else {
                ref.read(hoverProvider.notifier).state = "";
              }
            },
            child: Container(
              width: AppClass().getMqWidth(context) * 0.4,
              height: AppClass().getMqWidth(context) * 0.4,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          AppColors().blackColor,
                          isHovered ? BlendMode.lighten : BlendMode.color),
                      image: const AssetImage('assets/svg/profilePic.png')),
                  color: Colors.transparent),
            ),
          ),
        ],
      );
    });
  }
}
