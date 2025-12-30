import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final String link;
  const CustomIconButton({super.key, required this.icon, required this.link});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await launchUrl(Uri.parse(link));
        },
        icon: Container(height: 30, width: 30, child: SvgPicture.asset(icon)));
  }
}
