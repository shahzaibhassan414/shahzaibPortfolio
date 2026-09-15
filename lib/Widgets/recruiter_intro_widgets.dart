import 'package:flutter/material.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';
import '../resource/strings.dart';
import 'custom_social_icon.dart';

class RecruiterIntroHero extends StatefulWidget {
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
  State<RecruiterIntroHero> createState() => _RecruiterIntroHeroState();
}

class _RecruiterIntroHeroState extends State<RecruiterIntroHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _badgeFade;
  late final Animation<Offset> _badgeSlide;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _ctaFade;
  late final Animation<double> _cardFade;
  late final Animation<double> _cardScale;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _badgeFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );
    _badgeSlide = Tween<Offset>(
      begin: const Offset(0, -14),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    ));

    _textFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 24),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
    ));

    _ctaFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
    );

    _cardFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.25, 0.85, curve: Curves.easeOut),
    );
    _cardScale = Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.25, 0.85, curve: Curves.easeOutCubic),
    ));

    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final copy = _IntroCopy(
      onViewWork: widget.onViewWork,
      onContact: widget.onContact,
      compact: widget.compact,
      badgeFade: _badgeFade,
      badgeSlide: _badgeSlide,
      textFade: _textFade,
      textSlide: _textSlide,
      ctaFade: _ctaFade,
    );

    final codeCard = AnimatedBuilder(
      animation: _entryController,
      builder: (context, child) {
        return Opacity(
          opacity: _cardFade.value,
          child: Transform.scale(
            scale: _cardScale.value,
            child: child,
          ),
        );
      },
      child: _HeroCodeCard(compact: widget.compact),
    );

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: widget.compact ? double.infinity : 1220,
        ),
        child: widget.compact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  copy,
                  const SizedBox(height: 36),
                  Center(child: codeCard),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 11,
                    child: copy,
                  ),
                  const SizedBox(width: 42),
                  Expanded(
                    flex: 10,
                    child: codeCard,
                  ),
                ],
              ),
      ),
    );
  }
}

class _IntroCopy extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final bool compact;
  final Animation<double> badgeFade;
  final Animation<Offset> badgeSlide;
  final Animation<double> textFade;
  final Animation<Offset> textSlide;
  final Animation<double> ctaFade;

  const _IntroCopy({
    required this.onViewWork,
    required this.onContact,
    required this.compact,
    required this.badgeFade,
    required this.badgeSlide,
    required this.textFade,
    required this.textSlide,
    required this.ctaFade,
  });

  @override
  Widget build(BuildContext context) {
    final headlineSize = compact
        ? (MediaQuery.of(context).size.width < 390 ? 32.0 : 38.0)
        : 60.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: badgeFade,
          builder: (context, child) {
            return Opacity(
              opacity: badgeFade.value,
              child: Transform.translate(
                offset: badgeSlide.value,
                child: child,
              ),
            );
          },
          child: _AvailabilityIndicator(compact: compact),
        ),
        SizedBox(height: compact ? 16 : 20),
        AnimatedBuilder(
          animation: textFade,
          builder: (context, child) {
            return Opacity(
              opacity: textFade.value,
              child: Transform.translate(
                offset: textSlide.value,
                child: child,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.name,
                style: TextStyle(
                  color: AppColors().primaryColor,
                  fontFamily: 'sfmono',
                  fontSize: compact ? 13 : 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: compact ? 8 : 10),
              Semantics(
                header: true,
                child: Text(
                  Strings.introHeadline,
                  style: TextStyle(
                    color: AppColors().textColor,
                    fontSize: headlineSize,
                    height: 1.1,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.5,
                  ),
                ),
              ),
              SizedBox(height: compact ? 16 : 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Text(
                  Strings.introSummary,
                  style: TextStyle(
                    color: AppColors().textLight,
                    fontSize: compact ? 14 : 16,
                    height: compact ? 1.5 : 1.65,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: compact ? 22 : 30),
        AnimatedBuilder(
          animation: ctaFade,
          builder: (context, child) {
            return Opacity(
              opacity: ctaFade.value,
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _HeroButton(
                    label: 'Get in Touch',
                    icon: Icons.mail_outline_rounded,
                    filled: true,
                    onPressed: onContact,
                  ),
                  _HeroButton(
                    label: 'Chat on WhatsApp',
                    icon: Icons.chat_rounded,
                    isWhatsApp: true,
                    onPressed: () => AppClass().openPhoneNumber(
                      '923160984600',
                      prefilledMessage: 'Hi Shahzaib, I saw your portfolio and would like to discuss a Flutter project!',
                      context: context,
                    ),
                  ),
                  _HeroButton(
                    label: 'View Work',
                    icon: Icons.arrow_downward_rounded,
                    onPressed: onViewWork,
                  ),
                ],
              ),
              SizedBox(height: compact ? 22 : 28),
              const SocialIcons(),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvailabilityIndicator extends StatelessWidget {
  final bool compact;

  const _AvailabilityIndicator({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xff10B981), // Soft emerald
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff10B981).withValues(alpha: 0.5),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          Strings.introAvailability,
          style: TextStyle(
            color: AppColors().mutedTextColor,
            fontSize: compact ? 12 : 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;
  final bool isWhatsApp;

  const _HeroButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.filled = false,
    this.isWhatsApp = false,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.isWhatsApp ? const Color(0xff25D366) : AppColors().primaryColor;
    final bg = widget.filled
        ? (_isHovered ? Colors.white : accent)
        : (_isHovered ? accent.withValues(alpha: 0.12) : Colors.transparent);
    final fg = widget.filled ? AppColors().backgroundColor : accent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? accent : (widget.filled ? accent : AppColors().dividerColor),
          ),
          boxShadow: [
            if (widget.filled || _isHovered)
              BoxShadow(
                color: accent.withValues(alpha: widget.filled ? 0.18 : 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: fg, size: 17),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: fg,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
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

class _HeroCodeCard extends StatefulWidget {
  final bool compact;

  const _HeroCodeCard({this.compact = false});

  @override
  State<_HeroCodeCard> createState() => _HeroCodeCardState();
}

class _HeroCodeCardState extends State<_HeroCodeCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnim;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  void _handleCopy() {
    AppClass().copyToClipboard(
      '''class MobileEngineer {
  final name = 'Shahzaib Hassan';
  final role = 'Senior Flutter Developer';
  final experience = '4+ Years';

  final expertise = const [
    'Flutter & Dart Architecture',
    'In-App Purchases (RevenueCat)',
    'Stripe Checkout & Payments',
    'Google Maps & Live GPS',
    'WebSockets & Real-Time Sync',
    'App Store & Play Store Release',
  ];
}''',
      context,
      message: 'Code snippet copied to clipboard!',
    );
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.compact ? double.infinity : 480.0;

    final card = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Ambient Glow behind the card
            Positioned(
              top: 20,
              right: 20,
              left: 20,
              bottom: 20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors().primaryColor.withValues(alpha: 0.15),
                      blurRadius: 45,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),

            // Main Glassmorphic Code Card
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff0D1117), // Deep IDE Dark
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 36,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // IDE Header Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xff161B22),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Window Dots
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xffFF5F56),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xffFFBD2E),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xff27C93F),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Active Tab
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xff0D1117),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors().primaryColor.withValues(alpha: 0.4),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.flutter_dash,
                                color: Color(0xff54C5F8),
                                size: 13,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'developer.dart',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontFamily: 'sfmono',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),

                        // Copy Code Action
                        InkWell(
                          onTap: _handleCopy,
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _copied ? Icons.check : Icons.copy_rounded,
                                  color: _copied
                                      ? AppColors().primaryColor
                                      : const Color(0xff8B949E),
                                  size: 13,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _copied ? 'Copied' : 'Copy',
                                  style: TextStyle(
                                    color: _copied
                                        ? AppColors().primaryColor
                                        : const Color(0xff8B949E),
                                    fontFamily: 'sfmono',
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Code Content Area
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Line numbers
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(
                              13,
                              (i) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '${i + 1}'.padLeft(2, '0'),
                                  style: const TextStyle(
                                    color: Color(0xff484F58),
                                    fontFamily: 'sfmono',
                                    fontSize: 11,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Formatted Syntax Highlighting
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _codeLine([
                                _k('class '),
                                _t('MobileEngineer '),
                                _w('{'),
                              ]),
                              _codeLine([
                                const SizedBox(width: 14),
                                _k('final '),
                                _w('name = '),
                                _s('\'Shahzaib Hassan\''),
                                _w(';'),
                              ]),
                              _codeLine([
                                const SizedBox(width: 14),
                                _k('final '),
                                _w('role = '),
                                _s('\'Senior Flutter Developer\''),
                                _w(';'),
                              ]),
                              _codeLine([
                                const SizedBox(width: 14),
                                _k('final '),
                                _w('experience = '),
                                _s('\'4+ Years\''),
                                _w(';'),
                              ]),
                              _codeLine([
                                const SizedBox(height: 4),
                              ]),
                              _codeLine([
                                const SizedBox(width: 14),
                                _k('final '),
                                _w('expertise = '),
                                _k('const '),
                                _w('['),
                              ]),
                              _codeLine([
                                const SizedBox(width: 28),
                                _s('\'Flutter & Dart Architecture\''),
                                _w(','),
                              ]),
                              _codeLine([
                                const SizedBox(width: 28),
                                _s('\'In-App Purchases (RevenueCat)\''),
                                _w(','),
                              ]),
                              _codeLine([
                                const SizedBox(width: 28),
                                _s('\'Stripe Checkout & Payments\''),
                                _w(','),
                              ]),
                              _codeLine([
                                const SizedBox(width: 28),
                                _s('\'Google Maps & Live GPS\''),
                                _w(','),
                              ]),
                              _codeLine([
                                const SizedBox(width: 28),
                                _s('\'WebSockets & Real-Time Sync\''),
                                _w(','),
                              ]),
                              _codeLine([
                                const SizedBox(width: 14),
                                _w('];'),
                              ]),
                              _codeLine([
                                _w('}'),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: child,
        );
      },
      child: card,
    );
  }

  static Widget _codeLine(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  // Syntax tokens helper widgets
  static Widget _k(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xffFF7B72), // Keyword
          fontFamily: 'sfmono',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.45,
        ),
      );

  static Widget _t(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xff79C0FF), // Type / Class
          fontFamily: 'sfmono',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.45,
        ),
      );

  static Widget _s(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xff7EE787), // String
          fontFamily: 'sfmono',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.45,
        ),
      );

  static Widget _w(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xffE6EDF3), // Plain text
          fontFamily: 'sfmono',
          fontSize: 11,
          height: 1.45,
        ),
      );
}
