import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class ActionBar extends StatelessWidget implements PreferredSizeWidget {
  final AutoScrollController controller;

  const ActionBar(this.controller, {super.key});

  static const _items = <({String label, int index})>[
    (label: 'About', index: 1),
    (label: 'Experience', index: 2),
    (label: 'Skills', index: 3),
    (label: 'OSS', index: 4),
    (label: 'Projects', index: 5),
    (label: 'Writing', index: 6),
    (label: 'Contact', index: 7),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(76);

  void _scrollTo(int index) {
    controller.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = AppClass().getScreenType(context) != ScreenType.web;

    return Material(
      color: AppColors().backgroundColor.withValues(alpha: 0.96),
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors().dividerColor),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: Row(
              children: [
                InkWell(
                  onTap: () => _scrollTo(0),
                  child: Text(
                    'SH.',
                    style: TextStyle(
                      color: AppColors().textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
                const Spacer(),
                if (compact)
                  Builder(
                    builder: (context) => IconButton(
                      tooltip: 'Open navigation',
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      icon: Icon(
                        Icons.menu_rounded,
                        color: AppColors().textColor,
                        size: 27,
                      ),
                    ),
                  )
                else ...[
                  ..._items.map(
                    (item) => _NavItem(
                      label: item.label,
                      onTap: () => _scrollTo(item.index),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => AppClass().downloadResume(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors().primaryColor,
                      side: BorderSide(
                        color: AppColors().primaryColor.withValues(alpha: 0.45),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'sfmono',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    child: const Text('RESUME'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 18),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovered
                  ? AppColors().primaryColor
                  : AppColors().mutedTextColor,
              fontFamily: 'sfmono',
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
