import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../Widgets/custom_hover_button.dart';
import '../../Widgets/type_writer_text.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';

class IntroMobile extends StatefulWidget {
  final AutoScrollController aScrollController;

  IntroMobile(this.aScrollController, {Key? key}) : super(key: key);

  @override
  State<IntroMobile> createState() => _IntroMobileState();
}

class _IntroMobileState extends State<IntroMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      // height: AppClass().getMqHeight(context) - 200,
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: AppClass().getMqHeight(context) * 0.15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.welcomeTxt,
                style: TextStyle(color: AppColors().primaryRedColor, fontSize: AppClass().getMqWidth(context) * 0.045, fontFamily: 'sfmono'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                child: Text(
                  Strings.name,
                  style: GoogleFonts.robotoSlab(
                    color: AppColors().textColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: AppClass().getMqWidth(context) * 0.08,
                  ),
                ),
              ),
              TypeWriterText(
                text: Strings.whatIdo,
                fontSize: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: RichText(
                    text: TextSpan(
                        text: Strings.introAbout,
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          letterSpacing: 1,
                          height: 1.5,
                          fontSize: 18,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: Strings.currentOrgName,
                            style: GoogleFonts.roboto(
                              color: AppColors().primaryRedColor,
                              letterSpacing: 1,
                              height: 1.5,
                              fontSize: 18,
                            ),
                          )
                        ])),
              ),


              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 20),
                    child: CustomHoverButton(
                      text: "Check Out My Work!",
                      width: AppClass().getMqWidth(context) * 0.6,
                      height: AppClass().getMqHeight(context) * 0.07,
                      onTap: () {
                        widget.aScrollController.scrollToIndex(
                          4,
                          preferPosition: AutoScrollPosition.begin,
                        );
                      },
                    )),
              ),

              Align(
                alignment: Alignment.center,
                child: CustomHoverButton(
                  text: "Contact Me!",
                  width: AppClass().getMqWidth(context) * 0.6,
                  height: AppClass().getMqHeight(context) * 0.07,
                  onTap: () {
                    widget.aScrollController.scrollToIndex(
                      5,
                      preferPosition: AutoScrollPosition.begin,
                    );
                  },
                ),
              ),

              SizedBox(height: AppClass().getMqHeight(context) * 0.15,)
            ],
          ),
        ],
      ),
    );
  }
}
