import 'package:flutter/material.dart';

import '../model/experienceModel.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class ExperienceTimelineWidget extends StatefulWidget {
  final ExperienceWebModel experience;
  final bool isLast;
  final bool isFirst;

  const ExperienceTimelineWidget({
    super.key,
    required this.experience,
    this.isLast = false,
    this.isFirst = false,
  });

  @override
  State<ExperienceTimelineWidget> createState() =>
      _ExperienceTimelineWidgetState();
}

class _ExperienceTimelineWidgetState extends State<ExperienceTimelineWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isWeb = AppClass().getScreenType(context) == ScreenType.web;
    final visiblePoints =
        widget.experience.points.take(widget.isFirst ? 5 : 3).toList();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(isWeb ? 28 : 20),
        decoration: BoxDecoration(
          color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered
                ? AppColors().primaryColor.withValues(alpha: 0.4)
                : AppColors().dividerColor,
          ),
        ),
        child: isWeb
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 230, child: _Role(experience: widget.experience)),
                  const SizedBox(width: 38),
                  Expanded(child: _Points(points: visiblePoints)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Role(experience: widget.experience),
                  const SizedBox(height: 24),
                  _Points(points: visiblePoints),
                ],
              ),
      ),
    );
  }
}

class _Role extends StatelessWidget {
  final ExperienceWebModel experience;

  const _Role({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.duration.toUpperCase(),
          style: TextStyle(
            color: AppColors().primaryColor,
            fontFamily: 'sfmono',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          experience.desig,
          style: TextStyle(
            color: AppColors().textColor,
            fontSize: 22,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          experience.compName,
          style: TextStyle(
            color: AppColors().mutedTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Points extends StatelessWidget {
  final List<String> points;

  const _Points({required this.points});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: points
          .map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors().primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyle(
                        color: AppColors().mutedTextColor,
                        fontSize: 14,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
