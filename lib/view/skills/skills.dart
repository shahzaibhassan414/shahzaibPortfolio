import 'package:flutter/material.dart';

import '../../Widgets/custom_auto_slider.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/stacks_text_auto_slider.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  bool _showAllMobileSkills = false;

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final isMobile = screenType == ScreenType.mobile;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 130 : 56,
        horizontal,
        isWeb ? 50 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: 'Skills', isWeb: isWeb),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              'A practical toolkit for building, integrating, shipping, and maintaining real mobile products.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 17 : 14,
                height: isMobile ? 1.48 : 1.6,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 24 : 36),
          const _Label(text: 'CORE CAPABILITIES'),
          const SizedBox(height: 16),
          isMobile
              ? _CompactSkillChips(
                  items: AppClass().skills,
                  limit: _showAllMobileSkills ? null : 8,
                )
              : const StacksTextAutoSlider(),
          SizedBox(height: isMobile ? 24 : 44),
          const _Label(text: 'TOOLS & PLATFORMS'),
          const SizedBox(height: 16),
          isMobile
              ? _CompactToolGrid(
                  items: AppClass().skillsImages,
                  limit: _showAllMobileSkills ? null : 8,
                )
              : const SkillsAutoSlider(),
          if (isMobile &&
              (AppClass().skills.length > 8 ||
                  AppClass().skillsImages.length > 8)) ...[
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton.icon(
                onPressed: () => setState(
                  () => _showAllMobileSkills = !_showAllMobileSkills,
                ),
                icon: Icon(
                  _showAllMobileSkills
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.add_rounded,
                  size: 18,
                ),
                label: Text(
                  _showAllMobileSkills ? 'SHOW LESS' : 'SHOW ALL SKILLS',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors().primaryColor,
                  side: BorderSide(color: AppColors().dividerColor),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(
                    fontFamily: 'sfmono',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CompactSkillChips extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int? limit;

  const _CompactSkillChips({
    required this.items,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final visibleItems = limit == null ? items : items.take(limit!).toList();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: visibleItems
          .map(
            (skill) => _CompactSkillChip(label: skill['name']),
          )
          .toList(),
    );
  }
}

class _CompactSkillChip extends StatefulWidget {
  final String label;

  const _CompactSkillChip({required this.label});

  @override
  State<_CompactSkillChip> createState() => _CompactSkillChipState();
}

class _CompactSkillChipState extends State<_CompactSkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        scale: _hovered ? 1.03 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors().elevatedColor
                : AppColors().cardColor.withValues(alpha: 0.82),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: _hovered
                  ? AppColors().primaryColor.withValues(alpha: 0.5)
                  : AppColors().dividerColor,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: AppColors().primaryColor.withValues(alpha: 0.1),
                  blurRadius: 14,
                  offset: const Offset(0, 7),
                ),
            ],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color:
                  _hovered ? AppColors().primaryColor : AppColors().textColor,
              fontSize: 12,
              fontWeight: _hovered ? FontWeight.w700 : FontWeight.w600,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactToolGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int? limit;

  const _CompactToolGrid({
    required this.items,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final visibleItems = limit == null ? items : items.take(limit!).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;
        final width = (constraints.maxWidth - gap) / 2;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: visibleItems
              .map(
                (skill) => SizedBox(
                  width: width,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    decoration: BoxDecoration(
                      color: AppColors().cardColor.withValues(alpha: 0.82),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors().dividerColor),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          skill['image'],
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                          semanticLabel: '${skill['name']} development skill',
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            skill['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors().textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors().primaryColor,
        fontFamily: 'sfmono',
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }
}
