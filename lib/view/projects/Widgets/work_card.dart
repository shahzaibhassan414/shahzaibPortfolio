import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../resource/colors.dart';
import '../projectWeb.dart';
import '../project_detail_view.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailView(project: widget.project),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
            borderRadius: BorderRadius.circular(8),
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
                        semanticLabel:
                            '${widget.project.name} mobile app project preview',
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
                    if (widget.project.galleryImages.length > 1)
                      Positioned(
                        left: 14,
                        bottom: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors()
                                .backgroundColor
                                .withValues(alpha: 0.84),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: AppColors()
                                  .primaryColor
                                  .withValues(alpha: 0.35),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.photo_library_rounded,
                                color: AppColors().primaryColor,
                                size: 13,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.project.galleryImages.length} screens',
                                style: TextStyle(
                                  color: AppColors().textColor,
                                  fontFamily: 'sfmono',
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
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
                    if (widget.project.role != null ||
                        widget.project.timeline != null) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (widget.project.role != null)
                            _MetaPill(
                              icon: Icons.person_outline_rounded,
                              label: widget.project.role!,
                            ),
                          if (widget.project.timeline != null)
                            _MetaPill(
                              icon: Icons.grid_view_rounded,
                              label: widget.project.timeline!,
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],
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
                    if (widget.project.impact != null) ...[
                      const SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.bolt_rounded,
                            color: AppColors().primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.project.impact!,
                              style: TextStyle(
                                color: AppColors().textColor,
                                fontFamily: 'sfmono',
                                fontSize: 10,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (widget.project.highlights?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 14),
                      Column(
                        children: widget.project.highlights!
                            .take(2)
                            .map((highlight) => _HighlightLine(highlight))
                            .toList(),
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

class _MetaPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaPill({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors().backgroundColor.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors().dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors().primaryColor, size: 13),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: AppColors().mutedTextColor,
              fontFamily: 'sfmono',
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightLine extends StatelessWidget {
  final String text;

  const _HighlightLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 5,
            margin: const EdgeInsets.only(top: 7),
            decoration: BoxDecoration(
              color: AppColors().primaryColor,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
