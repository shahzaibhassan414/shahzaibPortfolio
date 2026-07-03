import 'package:flutter/material.dart';

import '../../Widgets/custom_social_icon.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class Footer extends StatelessWidget {
  final VoidCallback onBackToTop;

  const Footer({
    super.key,
    required this.onBackToTop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors().cardColor.withValues(alpha: 0.78),
              AppColors().backgroundColor.withValues(alpha: 0.28),
            ],
          ),
          border: Border(
            top: BorderSide(
              color: AppColors().primaryColor.withValues(alpha: 0.5),
              width: 2,
            ),
            bottom: BorderSide(color: AppColors().dividerColor),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 720;

            return Padding(
              padding: EdgeInsets.fromLTRB(
                compact ? 20 : 34,
                compact ? 28 : 34,
                compact ? 20 : 34,
                22,
              ),
              child: Column(
                children: [
                  if (compact)
                    _CompactFooter(onBackToTop: onBackToTop)
                  else
                    _DesktopFooter(onBackToTop: onBackToTop),
                  const SizedBox(height: 30),
                  Divider(color: AppColors().dividerColor, height: 1),
                  const SizedBox(height: 18),
                  _FooterMeta(compact: compact),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  final VoidCallback onBackToTop;

  const _DesktopFooter({required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _Monogram(size: 82),
        const SizedBox(width: 28),
        const Expanded(child: _SignOffCopy()),
        const SizedBox(width: 36),
        _FooterActions(onBackToTop: onBackToTop),
      ],
    );
  }
}

class _CompactFooter extends StatelessWidget {
  final VoidCallback onBackToTop;

  const _CompactFooter({required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Monogram(size: 62),
            _BackToTopButton(onPressed: onBackToTop),
          ],
        ),
        const SizedBox(height: 25),
        const _SignOffCopy(compact: true),
        const SizedBox(height: 24),
        const SizedBox(
          width: double.infinity,
          child: _EmailButton(expanded: true),
        ),
        const SizedBox(height: 20),
        const SocialIcons(),
      ],
    );
  }
}

class _Monogram extends StatelessWidget {
  final double size;

  const _Monogram({required this.size});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Shahzaib Hassan',
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors().primaryColor,
          borderRadius: BorderRadius.circular(size * 0.22),
          boxShadow: [
            BoxShadow(
              color: AppColors().primaryColor.withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          'SH.',
          style: TextStyle(
            color: AppColors().backgroundColor,
            fontSize: size * 0.32,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
          ),
        ),
      ),
    );
  }
}

class _SignOffCopy extends StatelessWidget {
  final bool compact;

  const _SignOffCopy({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'END OF PAGE  /  START OF SOMETHING GOOD',
          style: TextStyle(
            color: AppColors().primaryColor,
            fontFamily: 'sfmono',
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 11),
        Semantics(
          header: true,
          child: Text(
            'Thanks for stopping by.',
            style: TextStyle(
              color: AppColors().textColor,
              fontSize: compact ? 27 : 34,
              height: 1.1,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.9,
            ),
          ),
        ),
        const SizedBox(height: 9),
        Text(
          'Senior Flutter Developer building polished, production-ready '
          'products for iOS and Android.',
          style: TextStyle(
            color: AppColors().mutedTextColor,
            fontSize: compact ? 13 : 14,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _FooterActions extends StatelessWidget {
  final VoidCallback onBackToTop;

  const _FooterActions({required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const _EmailButton(),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SocialIcons(),
            const SizedBox(width: 12),
            _BackToTopButton(onPressed: onBackToTop),
          ],
        ),
      ],
    );
  }
}

class _EmailButton extends StatelessWidget {
  final bool expanded;

  const _EmailButton({this.expanded = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => AppClass().openEmail(AppClass.email),
      icon: const Icon(Icons.north_east_rounded, size: 17),
      label: const Text('SAY HELLO'),
      style: FilledButton.styleFrom(
        minimumSize: expanded ? const Size.fromHeight(50) : null,
        backgroundColor: AppColors().primaryColor,
        foregroundColor: AppColors().backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        textStyle: const TextStyle(
          fontFamily: 'sfmono',
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    );
  }
}

class _BackToTopButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BackToTopButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Back to top',
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_upward_rounded, size: 18),
        color: AppColors().mutedTextColor,
        style: IconButton.styleFrom(
          backgroundColor: AppColors().cardColor,
          side: BorderSide(color: AppColors().dividerColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class _FooterMeta extends StatelessWidget {
  final bool compact;

  const _FooterMeta({required this.compact});

  @override
  Widget build(BuildContext context) {
    final copyright = Text(
      '© 2026 SHAHZAIB HASSAN',
      style: TextStyle(
        color: AppColors().mutedTextColor,
        fontFamily: 'sfmono',
        fontSize: 9,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.9,
      ),
    );
    final signature = Text(
      'DESIGNED & BUILT IN FLUTTER',
      style: TextStyle(
        color: AppColors().mutedTextColor,
        fontFamily: 'sfmono',
        fontSize: 9,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.9,
      ),
    );

    if (compact) {
      return Column(
        children: [
          copyright,
          const SizedBox(height: 9),
          signature,
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [copyright, signature],
    );
  }
}
