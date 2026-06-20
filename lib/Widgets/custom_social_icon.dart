import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resource/colors.dart';

class SocialIcons extends StatelessWidget {
  final double? width;

  const SocialIcons({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIconItem(
          iconPath: 'assets/svg/github.svg',
          url: 'https://github.com/shahzaibhassan414',
          tooltip: 'GitHub',
        ),
        SizedBox(width: 10),
        _SocialIconItem(
          iconPath: 'assets/svg/linkedIn.svg',
          url: 'https://www.linkedin.com/in/shahzaibhassan414/',
          tooltip: 'LinkedIn',
        ),
        SizedBox(width: 10),
        _SocialIconItem(
          iconPath: 'assets/svg/instagram.svg',
          url: 'https://www.instagram.com/yaar_shiekh/?hl=en',
          tooltip: 'Instagram',
        ),
      ],
    );
  }
}

class _SocialIconItem extends StatefulWidget {
  final String iconPath;
  final String url;
  final String tooltip;

  const _SocialIconItem({
    required this.iconPath,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialIconItem> createState() => _SocialIconItemState();
}

class _SocialIconItemState extends State<_SocialIconItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors().primaryColor.withValues(alpha: 0.1)
                  : AppColors().cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _hovered
                    ? AppColors().primaryColor.withValues(alpha: 0.4)
                    : AppColors().dividerColor,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                widget.iconPath,
                color: _hovered
                    ? AppColors().primaryColor
                    : AppColors().mutedTextColor,
                width: 17,
                height: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
