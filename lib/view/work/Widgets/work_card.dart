import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/Widgets/custom_icon_button.dart';
import 'package:portfolio/resource/custom_svg.dart';
import 'package:portfolio/view/work/workWeb.dart';
import '../../../resource/appClass.dart';

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
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: AnimatedScale(
        scale: isHovered ? 1.03 : 1,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 200),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: isHovered ? 8 : 0,
          shadowColor: isHovered ? Colors.grey : null,
          child: Stack(
            children: [
              Image.asset(
                project.image,
                width: AppClass().getScreenType(context) == ScreenType.web ?
                AppClass().getMqWidth(context) * 0.22 : AppClass().getMqWidth(context) * 0.8,
                height: AppClass().getScreenType(context) == ScreenType.web ?
                AppClass().getMqWidth(context) * 0.18 : AppClass().getMqWidth(context) * 0.58,
                fit: BoxFit.cover,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                bottom: isHovered ? 0 : -50,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isHovered ? 1 : 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black.withValues(alpha: 0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          project.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (project.description != null &&
                            project.description!.isNotEmpty)
                          Text(
                            project.description!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (project.androidLink != null &&
                            project.iosLink != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                if (project.androidLink != null)
                                  CustomIconButton(
                                    icon: CustomSvg.playStoreIcon,
                                    link: project.androidLink!,
                                  ),
                                if (project.iosLink != null)
                                  CustomIconButton(
                                    icon: CustomSvg.appStoreIcon,
                                    link: project.iosLink!,
                                  ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
