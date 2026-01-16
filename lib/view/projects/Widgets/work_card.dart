import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/resource/colors.dart';
import '../../../resource/appClass.dart';
import '../projectWeb.dart';
import 'project_detail_dialog.dart';

class WorkCard extends StatelessWidget {
  final bool isHovered;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final ProjectModel project;

  const WorkCard({
    super.key,
    required this.isHovered,
    this.onEnter,
    this.onExit,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    bool isWeb = AppClass().getScreenType(context) == ScreenType.web;
    
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      cursor: SystemMouseCursors.none,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.7),
            builder: (context) => ProjectDetailDialog(project: project),
          );
        },
        child: AnimatedScale(
          scale: isHovered ? 1.05 : 1,
          curve: Curves.easeOutBack,
          duration: const Duration(milliseconds: 400),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: AppColors().primaryRedColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  // Project Image with Overlay
                  Image.asset(
                    project.image,
                    width: isWeb ? AppClass().getMqWidth(context) * 0.22 : AppClass().getMqWidth(context) * 0.85,
                    height: isWeb ? AppClass().getMqWidth(context) * 0.16 : AppClass().getMqWidth(context) * 0.55,
                    fit: BoxFit.cover,
                  ),
      
                  // Smooth Gradient Overlay
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Container(
                      width: isWeb ? AppClass().getMqWidth(context) * 0.22 : AppClass().getMqWidth(context) * 0.85,
                      height: isWeb ? AppClass().getMqWidth(context) * 0.16 : AppClass().getMqWidth(context) * 0.55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                            Colors.black.withValues(alpha: 0.95),
                          ],
                          stops: const [0.4, 0.8, 1.0],
                        ),
                      ),
                    ),
                  ),
      
                  // Project Details
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      padding: EdgeInsets.all(isHovered ? 16 : 8),
                      transform: Matrix4.translationValues(0, isHovered ? 0 : 20, 0),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isHovered ? 1 : 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              project.name.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Click to view details",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
