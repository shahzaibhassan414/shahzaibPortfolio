import 'package:flutter/material.dart';

import '../resource/colors.dart';
import '../resource/strings.dart';
import 'custom_social_icon.dart';

class RecruiterIntroHero extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final bool compact;

  const RecruiterIntroHero({
    super.key,
    required this.onViewWork,
    required this.onContact,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: compact ? double.infinity : 1080,
        ),
        child: _IntroCopy(
          onViewWork: onViewWork,
          onContact: onContact,
          compact: compact,
        ),
      ),
    );
  }
}

class _IntroCopy extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final bool compact;

  const _IntroCopy({
    required this.onViewWork,
    required this.onContact,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final headlineSize = compact
        ? (MediaQuery.of(context).size.width < 500 ? 40.0 : 52.0)
        : 70.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusPill(compact: compact),
        const SizedBox(height: 26),
        Text(
          Strings.name,
          style: TextStyle(
            color: AppColors().primaryColor,
            fontFamily: 'sfmono',
            fontSize: compact ? 14 : 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Semantics(
          header: true,
          child: Text(
            Strings.introHeadline,
            style: TextStyle(
              color: AppColors().textColor,
              fontSize: headlineSize,
              height: 1.06,
              fontWeight: FontWeight.w700,
              letterSpacing: -2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Text(
            Strings.introSummary,
            style: TextStyle(
              color: AppColors().textLight,
              fontSize: compact ? 16 : 18,
              height: 1.65,
            ),
          ),
        ),
        const SizedBox(height: 28),
        const _HeroProofRow(),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _HeroButton(
              label: 'VIEW SELECTED WORK',
              icon: Icons.arrow_downward_rounded,
              filled: true,
              onPressed: onViewWork,
            ),
            _HeroButton(
              label: 'LET’S TALK',
              icon: Icons.chat_bubble_outline_rounded,
              onPressed: onContact,
            ),
          ],
        ),
        const SizedBox(height: 28),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FIND ME ONLINE',
              style: TextStyle(
                color: Color(0xff64748B),
                fontFamily: 'sfmono',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: 14),
            SocialIcons(),
          ],
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool compact;

  const _StatusPill({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 11 : 14,
        vertical: compact ? 8 : 9,
      ),
      decoration: BoxDecoration(
        color: AppColors().primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors().primaryColor.withValues(alpha: 0.22),
        ),
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
                  color: AppColors().primaryColor.withValues(alpha: 0.65),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(width: 9),
          Flexible(
            child: Text(
              Strings.introAvailability.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors().primaryColor,
                fontFamily: 'sfmono',
                fontSize: compact ? 9 : 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroProofRow extends StatelessWidget {
  const _HeroProofRow();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 20,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _ProofItem(value: '4+', label: 'YEARS'),
        _ProofDivider(),
        _ProofItem(value: '15+', label: 'PROJECTS'),
        _ProofDivider(),
        _ProofItem(value: '10K+', label: 'DOWNLOADS'),
      ],
    );
  }
}

class _ProofItem extends StatelessWidget {
  final String value;
  final String label;

  const _ProofItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            color: AppColors().textColor,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: TextStyle(
            color: AppColors().mutedTextColor,
            fontFamily: 'sfmono',
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _ProofDivider extends StatelessWidget {
  const _ProofDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: AppColors().primaryColor.withValues(alpha: 0.2),
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;

  const _HeroButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.filled = false,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors().primaryColor;
    final foreground = widget.filled ? AppColors().backgroundColor : accent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: widget.filled
              ? (_isHovered ? Colors.white : accent)
              : (_isHovered
                  ? accent.withValues(alpha: 0.1)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent),
          boxShadow: widget.filled
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.16),
                    blurRadius: 20,
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: 9),
                Icon(widget.icon, color: foreground, size: 17),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
