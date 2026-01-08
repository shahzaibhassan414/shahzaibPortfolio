import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/resource/appClass.dart';

import '../../Widgets/main_title_widget.dart';
import '../../controller/generalController.dart';
import '../../model/experienceModel.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';
import 'experienceMob.dart';

class ExperienceTab extends StatefulWidget {
  const ExperienceTab({Key? key}) : super(key: key);

  @override
  State<ExperienceTab> createState() => _ExperienceTabState();
}

class _ExperienceTabState extends State<ExperienceTab> {
  @override
  Widget build(BuildContext context) {
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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainTitleWidget(
            title: "Experiences",
            isWeb: false,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(width: AppClass().getMqWidth(context) * 0.1,),
              ExperienceCardTab(
                key: ValueKey(0),
                experience: experienceList[0],
              )
            ],
          ),

          SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: AppColors().textLight,
              thickness: 1,
            ),
          ),
          SizedBox(height: 30,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(width: AppClass().getMqWidth(context) * 0.1,),
              ExperienceCardTab(
                key: ValueKey(1),
                experience: experienceList[1],
              )
            ],
          ),

          SizedBox(height: AppClass().getMqHeight(context) * 0.15,)
        ],
      ),
    );
  }
}


class ExperienceCardTab extends StatelessWidget {
  final ExperienceWebModel experience;
  const ExperienceCardTab({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    var mqWidth = AppClass().getMqWidth(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              experience.compName,
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
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: RichText(
              text: TextSpan(
                text: experience.desig,
                style: GoogleFonts.roboto(
                  color: AppColors().textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                children: [

                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              experience.duration,
              style: TextStyle(
                color: AppColors().textLight,
                fontSize: 14,
                fontFamily: 'sfmono',
              ),
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
                        width: mqWidth * 0.7,
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