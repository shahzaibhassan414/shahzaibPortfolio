import 'package:flutter/material.dart';

import '../resource/colors.dart';

class AboutStatsWidget extends StatelessWidget {
  const AboutStatsWidget({super.key});

  static const _stats = [
    _StatData(
      value: '4',
      label: 'Years shipping Flutter',
      icon: Icons.timeline_rounded,
    ),
    _StatData(
      value: '15+',
      label: 'Projects delivered',
      icon: Icons.rocket_launch_outlined,
    ),
    _StatData(
      value: '10K+',
      label: 'Downloads on one app',
      icon: Icons.download_rounded,
    ),
    _StatData(
      value: 'iOS + Android',
      label: 'Production releases',
      icon: Icons.phone_iphone_rounded,
      compactValue: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 950 ? 4 : 2;
        final gap = constraints.maxWidth < 400 ? 10.0 : 14.0;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: _stats
              .map(
                (stat) => SizedBox(
                  width: width,
                  child: _StatCard(data: stat),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _StatCard extends StatefulWidget {
  final _StatData data;

  const _StatCard({required this.data});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        constraints: const BoxConstraints(minHeight: 145),
        padding: const EdgeInsets.all(19),
        decoration: BoxDecoration(
          color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors().primaryColor.withValues(alpha: 0.4)
                : AppColors().dividerColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(widget.data.icon, color: AppColors().primaryColor, size: 21),
            const SizedBox(height: 22),
            Text(
              widget.data.value,
              maxLines: 1,
              style: TextStyle(
                color: AppColors().textColor,
                fontSize: widget.data.compactValue ? 19 : 29,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.data.label,
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatData {
  final String value;
  final String label;
  final IconData icon;
  final bool compactValue;

  const _StatData({
    required this.value,
    required this.label,
    required this.icon,
    this.compactValue = false,
  });
}
