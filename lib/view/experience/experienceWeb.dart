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

class _ExperienceWebState extends ConsumerState<ExperienceWeb> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mqWidth = AppClass().getMqWidth(context);

    return Container(
      width: mqWidth,
      margin: EdgeInsets.symmetric(horizontal: mqWidth * 0.05),
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: "Experiences"),
          const SizedBox(height: 30),
          
          _buildExperienceRow(0),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Divider(
              color: AppColors().textLight.withValues(alpha: 0.1),
              thickness: 1,
            ),
          ),
          
          _buildExperienceRow(1),
          
          SizedBox(height: mqWidth * 0.1),
        ],
      ),
    );
  }

  Widget _buildExperienceRow(int index) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppClass().getMqWidth(context) * 0.12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experienceList[index].compName,
                    style: TextStyle(
                      color: AppColors().primaryRedColor,
                      fontSize: 16,
                      fontFamily: 'sfmono',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    width: 30,
                    color: AppColors().primaryRedColor.withValues(alpha: 0.5),
                  )
                ],
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: ExperienceCardWeb(
                experience: experienceList[index],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExperienceCardWeb extends StatefulWidget {
  final ExperienceWebModel experience;
  const ExperienceCardWeb({super.key, required this.experience});

  @override
  State<ExperienceCardWeb> createState() => _ExperienceCardWebState();
}

class _ExperienceCardWebState extends State<ExperienceCardWeb> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    var mqWidth = AppClass().getMqWidth(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withValues(alpha: 0.02) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? AppColors().primaryRedColor.withValues(alpha: 0.1) : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: widget.experience.desig,
                style: GoogleFonts.roboto(
                  color: AppColors().textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                children: [
                  TextSpan(
                    text: " @${widget.experience.compName}",
                    style: GoogleFonts.roboto(
                      color: AppColors().primaryRedColor,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: AppColors().textLight.withValues(alpha: 0.5)),
                const SizedBox(width: 8),
                Text(
                  widget.experience.duration,
                  style: TextStyle(
                    color: AppColors().textLight.withValues(alpha: 0.7),
                    fontSize: 14,
                    fontFamily: 'sfmono',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.experience.points.asMap().entries.map((entry) {
                int idx = entry.key;
                String p = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.double_arrow_rounded,
                          size: 16,
                          color: AppColors().primaryRedColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          p,
                          style: TextStyle(
                            color: AppColors().textLight.withValues(alpha: 0.8),
                            fontSize: 15,
                            height: 1.6,
                            fontFamily: 'sfmono',
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
