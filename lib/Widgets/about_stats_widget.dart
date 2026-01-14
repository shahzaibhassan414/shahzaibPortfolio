import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class AboutStatsWidget extends StatefulWidget {
  const AboutStatsWidget({Key? key}) : super(key: key);

  @override
  State<AboutStatsWidget> createState() => _AboutStatsWidgetState();
}

class _AboutStatsWidgetState extends State<AboutStatsWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  bool _hasAppeared = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimations = List.generate(4, (index) {
      double start = index * 0.15;
      double end = start + 0.4;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end > 1.0 ? 1.0 : end, curve: Curves.easeOut),
        ),
      );
    });

    _slideAnimations = List.generate(4, (index) {
      double start = index * 0.15;
      double end = start + 0.4;
      return Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end > 1.0 ? 1.0 : end, curve: Curves.easeOutCubic),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-stats-visibility-key'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_hasAppeared) {
          _controller.forward();
          _hasAppeared = true;
        }
      },
      child: Column(
        children: [
          // Top Large Card
          FadeTransition(
            opacity: _fadeAnimations[0],
            child: SlideTransition(
              position: _slideAnimations[0],
              child: const _HoverStatCard(
                title: "3+",
                subtitle: "Years of Experience",
                description: "Building scalable mobile applications across diverse industries",
                trailing: _GradientIcon(icon: Icons.auto_awesome_outlined),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Middle Row
          Row(
            children: [
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimations[1],
                  child: SlideTransition(
                    position: _slideAnimations[1],
                    child: const _HoverStatCard(
                      title: "3+",
                      subtitle: "Years Flutter",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimations[2],
                  child: SlideTransition(
                    position: _slideAnimations[2],
                    child: const _HoverStatCard(
                      title: "15+",
                      subtitle: "Projects Delivered",
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Bottom Horizontal Card
          FadeTransition(
            opacity: _fadeAnimations[3],
            child: SlideTransition(
              position: _slideAnimations[3],
              child: const _HoverRoleCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverStatCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? description;
  final Widget? trailing;

  const _HoverStatCard({
    required this.title,
    required this.subtitle,
    this.description,
    this.trailing,
  });

  @override
  State<_HoverStatCard> createState() => _HoverStatCardState();
}

class _HoverStatCardState extends State<_HoverStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered 
              ? AppColors().primaryRedColor.withOpacity(0.1) 
              : AppColors().cardColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered 
                ? AppColors().primaryRedColor.withOpacity(0.5) 
                : AppColors().primaryRedColor.withOpacity(0.1),
          ),
          boxShadow: _isHovered ? [
            BoxShadow(
              color: AppColors().primaryRedColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ] : [],
        ),
        transform: _isHovered ? (Matrix4.identity()..translate(0, -5, 0)) : Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: GoogleFonts.roboto(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: _isHovered ? Colors.white : AppColors().primaryRedColor,
                  ),
                  child: Text(widget.title),
                ),
                if (widget.trailing != null) widget.trailing!,
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: AppColors().textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.description != null) ...[
              const SizedBox(height: 12),
              Text(
                widget.description!,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: AppColors().textLight,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HoverRoleCard extends StatefulWidget {
  const _HoverRoleCard();

  @override
  State<_HoverRoleCard> createState() => _HoverRoleCardState();
}

class _HoverRoleCardState extends State<_HoverRoleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: _isHovered 
              ? AppColors().primaryRedColor.withOpacity(0.1) 
              : AppColors().cardColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered 
                ? AppColors().primaryRedColor.withOpacity(0.5) 
                : AppColors().primaryRedColor.withOpacity(0.1),
          ),
          boxShadow: _isHovered ? [
            BoxShadow(
              color: AppColors().primaryRedColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ] : [],
        ),
        transform: _isHovered ? (Matrix4.identity()..translate(0, -5, 0)) : Matrix4.identity(),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: AppColors().textLight,
              height: 1.5,
            ),
            children: [
              const TextSpan(text: "Currently "),
              TextSpan(
                text: "Senior Flutter Developer",
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors().textColor),
              ),
              const TextSpan(text: " at "),
              TextSpan(
                text: "Code Encoders",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors().primaryRedColor,
                ),
              ),
              const TextSpan(text: ", leading multi-platform Flutter development."),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientIcon extends StatelessWidget {
  final IconData icon;
  const _GradientIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors().primaryRedColor.withOpacity(0.2),
            AppColors().primaryRedColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColors().primaryRedColor, size: 24),
    );
  }
}
