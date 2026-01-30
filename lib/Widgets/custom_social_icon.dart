import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/generalController.dart';
import '../resource/colors.dart';

class SocialIcons extends StatelessWidget {
  final double? width;
  const SocialIcons({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SocialIconItem(
            iconPath: 'assets/svg/github.svg',
            url: 'https://github.com/shahzaibhassan414',
            hoverKey: 'git',
          ),
          const SizedBox(width: 15),
          _SocialIconItem(
            iconPath: 'assets/svg/instagram.svg',
            url: 'https://www.instagram.com/yaar_shiekh/?hl=en',
            hoverKey: 'insta',
          ),
          const SizedBox(width: 15),
          _SocialIconItem(
            iconPath: 'assets/svg/linkedIn.svg',
            url: 'https://www.linkedin.com/in/shahzaibhassan414/',
            hoverKey: 'linkedIn',
          ),
        ],
      ),
    );
  }
}

class _SocialIconItem extends ConsumerWidget {
  final String iconPath;
  final String url;
  final String hoverKey;

  const _SocialIconItem({
    required this.iconPath,
    required this.url,
    required this.hoverKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref.watch(hoverProvider);
    final bool isHovered = hoverState == hoverKey;

    return MouseRegion(
      onEnter: (_) => ref.read(hoverProvider.notifier).state = hoverKey,
      onExit: (_) => ref.read(hoverProvider.notifier).state = '',
      child: GestureDetector(
        onTap: () async => await launchUrl(Uri.parse(url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: isHovered 
                ? AppColors().primaryRedColor.withValues(alpha:0.1)
                : Colors.white.withValues(alpha:0.03),
            shape: BoxShape.circle,
            border: Border.all(
              color: isHovered 
                  ? AppColors().primaryRedColor 
                  : Colors.white.withValues(alpha:0.1),
              width: 1.5,
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: AppColors().primaryRedColor.withValues(alpha:0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              color: isHovered ? AppColors().primaryRedColor : AppColors().textColor,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
