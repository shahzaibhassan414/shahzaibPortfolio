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
    bool isWeb = AppClass().getScreenType(context) == ScreenType.web;
    
    Widget content = MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.02 : 1,
        curve: Curves.easeOutBack,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: (){
            if(widget.title == 'Email Address'){
              AppClass().openEmail(widget.value);
            }else{
              AppClass().openPhoneNumber('923190984600');
            }
          },
          child: AnimatedContainer(
            width: isWeb ? null : double.infinity,
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: AppColors().cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHovered 
                    ? AppColors().primaryRedColor.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha:0.05),
                width: 1.5,
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: AppColors().primaryRedColor.withValues(alpha:0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isHovered 
                        ? AppColors().primaryRedColor.withValues(alpha:0.1)
                        : Colors.white.withValues(alpha:0.02),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: isHovered ? AppColors().primaryRedColor : AppColors().textLight,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.title,
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.value,
                  style: TextStyle(
                    color: isHovered ? AppColors().textColor : AppColors().textLight,
                    fontSize: 14,
                    fontFamily: 'sfmono',
                    letterSpacing: 0.5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    return isWeb ? Expanded(child: content) : content;
  }
}
