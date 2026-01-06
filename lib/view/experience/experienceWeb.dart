import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/resource/appClass.dart';

import '../../Widgets/main_title_widget.dart';
import '../../controller/generalController.dart';
import '../../model/experienceModel.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';

class ExperienceWeb extends ConsumerStatefulWidget {
  const ExperienceWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<ExperienceWeb> createState() => _ExperienceWebState();
}

class _ExperienceWebState extends ConsumerState<ExperienceWeb> {
  List<ExperienceWebModel> experienceList = [
    ExperienceWebModel(
      desig: Strings.expDesig2,
      compName: Strings.expCompName2,
      duration: Strings.expDur2,
      points: [
        Strings.expAbout2,
        Strings.expAbout2_2,
        Strings.expAbout2_3,
        Strings.expAbout2_4,
        Strings.expAbout2_5,
        Strings.expAbout2_6,
        Strings.expAbout2_7,
        Strings.expAbout2_8,
      ],
    ),
    ExperienceWebModel(
      desig: Strings.expDesig1,
      compName: Strings.expCompName1,
      duration: Strings.expDur1,
      points: [
        Strings.expAbout1,
        Strings.expAbout1_2,
        Strings.expAbout1_3,
        Strings.expAbout1_4,
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mqWidth = AppClass().getMqWidth(context);

    final selectedIndex = ref.watch(selectedExpProvider);

    return Container(
      width: mqWidth,
      margin: EdgeInsets.only(
          left: AppClass().getMqWidth(context) * 0.03,
          right: AppClass().getMqWidth(context) * 0.03),
      padding: const EdgeInsets.symmetric(vertical: 50,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          MainTitleWidget(
            number: "02",
            title: "Experiences",
          ),


          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppClass().getMqWidth(context) * 0.08,
                child: Text(
                  experienceList[0].compName,
                  style: TextStyle(
                    color:
                    AppColors().primaryRedColor,
                    fontSize: 16,
                    fontFamily: 'sfmono',
                    fontWeight:
                    FontWeight.bold
                  ),
                ),
              ),

              SizedBox(width: AppClass().getMqWidth(context) * 0.1,),
              ExperienceCardWeb(
                key: ValueKey(0),
                experience: experienceList[0],
              )
            ],
          ),

          Divider(
            color: AppColors().textLight,
            thickness: 1,
          ),
          SizedBox(height: 30,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppClass().getMqWidth(context) * 0.08,
                child: Text(
                  experienceList[1].compName,
                  style: TextStyle(
                      color:
                      AppColors().primaryRedColor,
                      fontSize: 16,
                      fontFamily: 'sfmono',
                      fontWeight:
                      FontWeight.bold
                  ),
                ),
              ),

              SizedBox(width: AppClass().getMqWidth(context) * 0.1,),
              ExperienceCardWeb(
                key: ValueKey(1),
                experience: experienceList[1],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ExperienceCardWeb extends StatelessWidget {
  final ExperienceWebModel experience;
  const ExperienceCardWeb({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    var mqWidth = AppClass().getMqWidth(context);

    return SizedBox(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: experience.desig,
              style: GoogleFonts.roboto(
                color: AppColors().textColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              children: [
                TextSpan(
                  text: " @${experience.compName}",
                  style: GoogleFonts.roboto(
                    color: AppColors().primaryRedColor,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            experience.duration,
            style: TextStyle(
              color: AppColors().textLight,
              fontSize: 14,
              fontFamily: 'sfmono',
            ),
          ),
          SizedBox(height: 15),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: experience.points
                  .map(
                    (p) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_right,
                        size: 20,
                        color: AppColors().primaryRedColor,
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: mqWidth * 0.45,
                        child: Text(
                          p,
                          style: TextStyle(
                            color: AppColors().textLight,
                            fontSize: 14,
                            height: 1.5,
                            fontFamily: 'sfmono',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
