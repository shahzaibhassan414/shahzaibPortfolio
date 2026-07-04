import 'package:flutter/material.dart';

import '../resource/appClass.dart';
import '../resource/colors.dart';

class StacksTextAutoSlider extends StatelessWidget {
  const StacksTextAutoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: AppClass()
          .skills
          .map(
            (skill) => _StackSkillChip(label: skill['name']),
          )
          .toList(),
    );
  }
}

class _StackSkillChip extends StatefulWidget {
  final String label;

  const _StackSkillChip({required this.label});

  @override
  State<_StackSkillChip> createState() => _StackSkillChipState();
}

class _StackSkillChipState extends State<_StackSkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 170),
        curve: Curves.easeOutCubic,
        scale: _hovered ? 1.035 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors().elevatedColor
                : AppColors().cardColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? AppColors().primaryColor.withValues(alpha: 0.52)
                  : AppColors().dividerColor,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: AppColors().primaryColor.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 170),
            curve: Curves.easeOutCubic,
            style: TextStyle(
              color:
                  _hovered ? AppColors().primaryColor : AppColors().textColor,
              fontSize: 13,
              fontWeight: _hovered ? FontWeight.w700 : FontWeight.w500,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
