import 'package:flutter/material.dart';

import '../resource/appClass.dart';
import '../resource/colors.dart';

class SkillsAutoSlider extends StatelessWidget {
  const SkillsAutoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = AppClass().getScreenType(context) == ScreenType.web;
    final itemWidth = isWeb ? 150.0 : 118.0;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: AppClass()
          .skillsImages
          .map(
            (skill) => SizedBox(
              width: itemWidth,
              child: _SkillTile(skill: skill, isWeb: isWeb),
            ),
          )
          .toList(),
    );
  }
}

class _SkillTile extends StatefulWidget {
  final Map<String, dynamic> skill;
  final bool isWeb;

  const _SkillTile({required this.skill, required this.isWeb});

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: widget.isWeb ? 132 : 108,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors().elevatedColor
              : AppColors().cardColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? AppColors().primaryColor.withValues(alpha: 0.45)
                : AppColors().dividerColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.skill['image'],
              width: widget.isWeb ? 46 : 36,
              height: widget.isWeb ? 46 : 36,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
            ),
            const SizedBox(height: 12),
            Text(
              widget.skill['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _hovered
                    ? AppColors().textColor
                    : AppColors().mutedTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
