import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/resource/appClass.dart';
import '../resource/colors.dart';

class CustomContactCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  const CustomContactCard({
    super.key,
    required this.title,
    required this.value, required this.icon,
  });

  @override
  State<CustomContactCard> createState() => _CustomContactCardState();
}

class _CustomContactCardState extends State<CustomContactCard> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AppClass().getScreenType(context) == ScreenType.web ?
      Expanded(
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedScale(
          scale: isHovered ? 1.02 : 1,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 200),
          child: Card(
            elevation: isHovered ? 8 : 0,
            shadowColor: isHovered ? Colors.grey : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color:isHovered ? null : AppColors().cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                   widget.icon,
                    color:
                        isHovered ?
                    AppColors().primaryRedColor : AppColors().textLight,
                    size: 40,),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.robotoSlab(
                      color: AppColors().textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(widget.value,
                      style: TextStyle(
                          color: AppColors().textLight,
                          fontSize: 14,
                          fontFamily: 'sfmono'))
                ],
              ),
            ),
          ),
        ),
      ),
    ) :
    MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.02 : 1,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 200),
        child: Card(
          elevation: isHovered ? 8 : 0,
          shadowColor: isHovered ? Colors.grey : null,
          child: AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color:isHovered ? null : AppColors().cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color:
                  isHovered ?
                  AppColors().primaryRedColor : AppColors().textLight,
                  size: 40,),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.title,
                  style: GoogleFonts.robotoSlab(
                    color: AppColors().textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(widget.value,
                    style: TextStyle(
                        color: AppColors().textLight,
                        fontSize: 14,
                        fontFamily: 'sfmono'))
              ],
            ),
          ),
        ),
      ),
    )
    ;
  }
}
