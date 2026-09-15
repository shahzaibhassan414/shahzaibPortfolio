import 'package:flutter/material.dart';
import '../../Widgets/main_title_widget.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class Services extends StatelessWidget {
  final VoidCallback onStartProject;

  const Services({
    super.key,
    required this.onStartProject,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final isMobile = screenType == ScreenType.mobile;
    final horizontal = isMobile ? 20.0 : 38.0;
    final services = AppClass().services;

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
            title: 'Services',
            isWeb: isWeb,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'End-to-end mobile engineering across iOS and Android, focusing on scalable architecture, reliability, and smooth performance.',
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
              final isTwoColumn = constraints.maxWidth >= 780;
              final itemWidth = isTwoColumn
                  ? (constraints.maxWidth - 20) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: services
                    .map(
                      (service) => SizedBox(
                        width: itemWidth,
                        child: _ServiceBentoCard(
                          service: service,
                          isMobile: isMobile,
                          onTap: onStartProject,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceBentoCard extends StatefulWidget {
  final ServiceOffering service;
  final bool isMobile;
  final VoidCallback onTap;

  const _ServiceBentoCard({
    required this.service,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<_ServiceBentoCard> createState() => _ServiceBentoCardState();
}

class _ServiceBentoCardState extends State<_ServiceBentoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors().primaryColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(widget.isMobile ? 20 : 28),
          decoration: BoxDecoration(
            color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? accent.withValues(alpha: 0.5) : AppColors().dividerColor,
              width: _hovered ? 1.4 : 1.0,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: accent.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accent.withValues(alpha: 0.25)),
                    ),
                    child: Icon(widget.service.icon, color: accent, size: 24),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: _hovered ? accent : AppColors().mutedTextColor,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.service.title,
                style: TextStyle(
                  color: AppColors().textColor,
                  fontSize: widget.isMobile ? 18 : 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.service.description,
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontSize: widget.isMobile ? 13 : 15,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors().backgroundColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, color: accent, size: 14),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        widget.service.outcome,
                        style: TextStyle(
                          color: AppColors().textColor,
                          fontFamily: 'sfmono',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.service.tags
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors().backgroundColor.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors().dividerColor),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: AppColors().mutedTextColor,
                            fontFamily: 'sfmono',
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
