import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../resource/colors.dart';
import '../projectWeb.dart';
import 'project_detail_dialog.dart';

class WorkCard extends StatefulWidget {
  final ProjectModel project;

  // Kept for compatibility with older responsive view files.
  final bool isHovered;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;

  const WorkCard({
    super.key,
    required this.project,
    this.isHovered = false,
    this.onEnter,
    this.onExit,
  });

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() => _hovered = true);
        widget.onEnter?.call(event);
      },
      onExit: (event) {
        setState(() => _hovered = false);
        widget.onExit?.call(event);
      },
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.78),
            builder: (context) => ProjectDetailDialog(project: widget.project),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? AppColors().primaryColor.withValues(alpha: 0.4)
                  : AppColors().dividerColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.45,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      scale: _hovered ? 1.025 : 1,
                      duration: const Duration(milliseconds: 220),
                      child: Image.asset(
                        widget.project.image,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0x660B1218)],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors()
                              .backgroundColor
                              .withValues(alpha: 0.82),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_outward_rounded,
                          color: AppColors().textColor,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.name,
                      style: TextStyle(
                        color: AppColors().textColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (widget.project.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.project.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors().mutedTextColor,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                    if (widget.project.techs?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: widget.project.techs!
                            .take(3)
                            .map(
                              (tech) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors()
                                      .backgroundColor
                                      .withValues(alpha: 0.55),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyle(
                                    color: AppColors().mutedTextColor,
                                    fontFamily: 'sfmono',
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
