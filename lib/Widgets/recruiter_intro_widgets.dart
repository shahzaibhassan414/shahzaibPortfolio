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
          maxWidth: compact ? double.infinity : 1180,
        ),
        child: compact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IntroCopy(
                    onViewWork: onViewWork,
                    onContact: onContact,
                    compact: compact,
                  ),
                  const SizedBox(height: 34),
                  const Center(child: _HeroDeviceScene(compact: true)),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: _IntroCopy(
                      onViewWork: onViewWork,
                      onContact: onContact,
                      compact: compact,
                    ),
                  ),
                  const SizedBox(width: 46),
                  const Expanded(
                    flex: 7,
                    child: _HeroDeviceScene(),
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

  const _IntroCopy({
    required this.onViewWork,
    required this.onContact,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final headlineSize = compact
        ? (MediaQuery.of(context).size.width < 390 ? 34.0 : 38.0)
        : 70.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusPill(compact: compact),
        SizedBox(height: compact ? 18 : 26),
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
        SizedBox(height: compact ? 9 : 12),
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
        SizedBox(height: compact ? 16 : 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Text(
            Strings.introSummary,
            style: TextStyle(
              color: AppColors().textLight,
              fontSize: compact ? 15 : 18,
              height: compact ? 1.52 : 1.65,
            ),
          ),
        ),
        SizedBox(height: compact ? 20 : 28),
        const _HeroProofRow(),
        SizedBox(height: compact ? 22 : 32),
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
        SizedBox(height: compact ? 22 : 28),
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

class _HeroDeviceScene extends StatefulWidget {
  final bool compact;

  const _HeroDeviceScene({this.compact = false});

  @override
  State<_HeroDeviceScene> createState() => _HeroDeviceSceneState();
}

class _HeroDeviceSceneState extends State<_HeroDeviceScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableMotion = MediaQuery.of(context).disableAnimations;
    final width = widget.compact ? 300.0 : 360.0;
    final height = widget.compact ? 310.0 : 410.0;

    return Semantics(
      label: 'Animated 3D mobile app preview',
      child: SizedBox(
        width: width,
        height: height,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = disableMotion ? 0.42 : _controller.value;
            final lift = disableMotion ? 0.0 : (t - 0.5) * 18;
            final tiltY = -0.22 + (t * 0.11);
            final tiltX = 0.10 - (t * 0.05);

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: widget.compact ? 18 : 28,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(1.18),
                    child: Container(
                      width: widget.compact ? 220 : 265,
                      height: widget.compact ? 86 : 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: RadialGradient(
                          colors: [
                            AppColors().primaryColor.withValues(alpha: 0.24),
                            AppColors().primaryColor.withValues(alpha: 0.03),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: widget.compact ? 16 : 8,
                  top: widget.compact ? 32 : 52,
                  child: _FloatingPanel(
                    width: widget.compact ? 106 : 126,
                    title: 'LIVE',
                    value: '98%',
                    icon: Icons.speed_rounded,
                    offset: -lift * 0.45,
                  ),
                ),
                Positioned(
                  left: widget.compact ? 12 : 0,
                  bottom: widget.compact ? 40 : 76,
                  child: _FloatingPanel(
                    width: widget.compact ? 118 : 138,
                    title: 'STACK',
                    value: 'Flutter',
                    icon: Icons.layers_rounded,
                    offset: lift * 0.35,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, lift),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0012)
                      ..rotateX(tiltX)
                      ..rotateY(tiltY)
                      ..rotateZ(-0.035),
                    child: const _DeviceBody(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DeviceBody extends StatelessWidget {
  const _DeviceBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 318,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff071015),
        borderRadius: BorderRadius.circular(34),
        border: Border.all(
          color: AppColors().primaryColor.withValues(alpha: 0.24),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.42),
            blurRadius: 34,
            offset: const Offset(22, 24),
          ),
          BoxShadow(
            color: AppColors().primaryColor.withValues(alpha: 0.16),
            blurRadius: 42,
            offset: const Offset(-12, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Container(
          color: AppColors().cardColor,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _DeviceGridPainter()),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _SignalDot(color: AppColors().primaryColor),
                        const SizedBox(width: 6),
                        _SignalDot(
                          color:
                              AppColors().primaryColor.withValues(alpha: 0.5),
                        ),
                        const Spacer(),
                        Container(
                          width: 46,
                          height: 7,
                          decoration: BoxDecoration(
                            color: AppColors()
                                .backgroundColor
                                .withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Text(
                      'APP BUILD',
                      style: TextStyle(
                        color: AppColors().primaryColor,
                        fontFamily: 'sfmono',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Smooth mobile experiences',
                      style: TextStyle(
                        color: AppColors().textColor,
                        fontSize: 21,
                        height: 1.12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const _ProgressLine(value: 0.86, label: 'UI'),
                    const SizedBox(height: 10),
                    const _ProgressLine(value: 0.72, label: 'API'),
                    const SizedBox(height: 10),
                    const _ProgressLine(value: 0.64, label: 'STORE'),
                    const Spacer(),
                    const Row(
                      children: [
                        _MiniMetric(value: '15+', label: 'apps'),
                        SizedBox(width: 10),
                        _MiniMetric(value: '4+', label: 'yrs'),
                      ],
                    ),
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

class _FloatingPanel extends StatelessWidget {
  final double width;
  final String title;
  final String value;
  final IconData icon;
  final double offset;

  const _FloatingPanel({
    required this.width,
    required this.title,
    required this.value,
    required this.icon,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors().elevatedColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors().dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 22,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors().primaryColor, size: 17),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors().mutedTextColor,
                      fontFamily: 'sfmono',
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors().textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignalDot extends StatelessWidget {
  final Color color;

  const _SignalDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  final double value;
  final String label;

  const _ProgressLine({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 42,
          child: Text(
            label,
            style: TextStyle(
              color: AppColors().mutedTextColor,
              fontFamily: 'sfmono',
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 7,
              color: AppColors().primaryColor,
              backgroundColor: AppColors().backgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniMetric extends StatelessWidget {
  final String value;
  final String label;

  const _MiniMetric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: AppColors().backgroundColor.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors().dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: AppColors().textColor,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontFamily: 'sfmono',
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors().primaryColor.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    for (var x = -size.height; x < size.width; x += 24) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        linePaint,
      );
    }

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors().primaryColor.withValues(alpha: 0.2),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.78, size.height * 0.18),
          radius: size.width * 0.75,
        ),
      );

    canvas.drawRect(Offset.zero & size, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
