import 'package:flutter/material.dart';
import '../../Widgets/main_title_widget.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final isMobile = screenType == ScreenType.mobile;
    final horizontal = isMobile ? 20.0 : 38.0;
    final testimonials = AppClass().testimonials;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 120 : 56,
        horizontal,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(
            title: 'Testimonials',
            isWeb: isWeb,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Feedback from founders and engineering leads on delivered projects.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 16 : 14,
                height: isMobile ? 1.48 : 1.6,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 24 : 36),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 960) {
                // 3 columns on wide screens
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < testimonials.length; i++) ...[
                      Expanded(
                        child: _TestimonialCard(
                          testimonial: testimonials[i],
                          isMobile: isMobile,
                        ),
                      ),
                      if (i != testimonials.length - 1) const SizedBox(width: 20),
                    ],
                  ],
                );
              } else {
                // Carousel on mobile / tablet
                final item = testimonials[_currentIndex % testimonials.length];
                return Column(
                  children: [
                    _TestimonialCard(
                      testimonial: item,
                      isMobile: isMobile,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left_rounded),
                          color: AppColors().primaryColor,
                          onPressed: () => setState(() {
                            _currentIndex = (_currentIndex - 1 + testimonials.length) %
                                testimonials.length;
                          }),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${_currentIndex + 1} / ${testimonials.length}',
                          style: TextStyle(
                            color: AppColors().mutedTextColor,
                            fontFamily: 'sfmono',
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.chevron_right_rounded),
                          color: AppColors().primaryColor,
                          onPressed: () => setState(() {
                            _currentIndex = (_currentIndex + 1) % testimonials.length;
                          }),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatefulWidget {
  final TestimonialModel testimonial;
  final bool isMobile;

  const _TestimonialCard({
    required this.testimonial,
    required this.isMobile,
  });

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors().primaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(widget.isMobile ? 20 : 26),
        decoration: BoxDecoration(
          color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? accent.withValues(alpha: 0.4) : AppColors().dividerColor,
          ),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: accent.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xffFFB800),
                    size: 18,
                  ),
                const Spacer(),
                Icon(
                  Icons.format_quote_rounded,
                  color: accent.withValues(alpha: 0.4),
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '"${widget.testimonial.quote}"',
              style: TextStyle(
                color: AppColors().textColor,
                fontSize: widget.isMobile ? 14 : 15,
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              height: 1,
              color: AppColors().dividerColor,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: accent.withValues(alpha: 0.3)),
                  ),
                  child: Center(
                    child: Text(
                      widget.testimonial.author[0],
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.testimonial.author,
                        style: TextStyle(
                          color: AppColors().textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.testimonial.role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors().mutedTextColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors().backgroundColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'PROJECT: ${widget.testimonial.project}',
                style: TextStyle(
                  color: accent,
                  fontFamily: 'sfmono',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
