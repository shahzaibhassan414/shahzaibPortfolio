import 'package:flutter/material.dart';

import '../resource/colors.dart';
import '../resource/strings.dart';

class RecruiterAboutCopy extends StatelessWidget {
  final bool centered;
  final double headlineSize;

  const RecruiterAboutCopy({
    super.key,
    this.centered = false,
    this.headlineSize = 44,
  });

  @override
  Widget build(BuildContext context) {
    final alignment =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors().primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors().primaryColor.withValues(alpha: 0.25),
            ),
          ),
          child: Text(
            Strings.aboutEyebrow,
            style: TextStyle(
              color: AppColors().primaryColor,
              fontFamily: 'sfmono',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          Strings.aboutHeadline,
          textAlign: textAlign,
          style: TextStyle(
            color: AppColors().textColor,
            fontSize: headlineSize,
            height: 1.15,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          Strings.aboutSummary,
          textAlign: textAlign,
          style: TextStyle(
            color: AppColors().textLight,
            fontSize: 17,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: Strings.aboutCapabilities
              .map((capability) => _CapabilityChip(label: capability))
              .toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_outward_rounded,
              color: AppColors().primaryColor,
              size: 17,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                Strings.aboutExploring,
                textAlign: textAlign,
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AboutActionButtons extends StatelessWidget {
  final VoidCallback onViewProjects;
  final bool centered;

  const AboutActionButtons({
    super.key,
    required this.onViewProjects,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: centered ? WrapAlignment.center : WrapAlignment.start,
      spacing: 12,
      runSpacing: 12,
      children: [
        _AboutButton(
          label: 'VIEW PROJECTS',
          icon: Icons.arrow_downward_rounded,
          filled: true,
          onPressed: onViewProjects,
        ),
      ],
    );
  }
}

class RecruiterProfileCard extends StatefulWidget {
  final double maxWidth;

  const RecruiterProfileCard({
    super.key,
    this.maxWidth = 390,
  });

  @override
  State<RecruiterProfileCard> createState() => _RecruiterProfileCardState();
}

class _RecruiterProfileCardState extends State<RecruiterProfileCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        constraints: BoxConstraints(maxWidth: widget.maxWidth),
        transform: _isHovered
            ? Matrix4.translationValues(0, -6, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: AppColors()
                .primaryColor
                .withValues(alpha: _isHovered ? 0.65 : 0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors()
                  .primaryColor
                  .withValues(alpha: _isHovered ? 0.16 : 0.08),
              blurRadius: _isHovered ? 36 : 24,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: AspectRatio(
            aspectRatio: 0.76,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/svg/profilePic.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.45, 1],
                      colors: [Colors.transparent, Color(0xF2020617)],
                    ),
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 18,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xD9020617),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors().primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors()
                                    .primaryColor
                                    .withValues(alpha: 0.7),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'OPEN TO GREAT PRODUCTS',
                          style: TextStyle(
                            color: AppColors().textColor,
                            fontFamily: 'sfmono',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shahzaib Hassan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Senior Flutter Developer · Code Encoders',
                        style: TextStyle(
                          color: AppColors().textLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CapabilityChip extends StatelessWidget {
  final String label;

  const _CapabilityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors().cardColor.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors().primaryColor.withValues(alpha: 0.13),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors().textColor,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _AboutButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;

  const _AboutButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.filled = false,
  });

  @override
  State<_AboutButton> createState() => _AboutButtonState();
}

class _AboutButtonState extends State<_AboutButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors().primaryColor;
    final background = widget.filled
        ? (_isHovered ? Colors.white : accent)
        : (_isHovered ? accent.withValues(alpha: 0.1) : Colors.transparent);
    final foreground = widget.filled ? AppColors().backgroundColor : accent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent),
          boxShadow: widget.filled
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: _isHovered ? 0.25 : 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    color: foreground,
                    fontFamily: 'sfmono',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(widget.icon, color: foreground, size: 17),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
