import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/generalController.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class SocialIcons extends StatefulWidget {
  final double? width;
  const SocialIcons({super.key, this.width});

  @override
  State<SocialIcons> createState() => _SocialIconsState();
}

class _SocialIconsState extends State<SocialIcons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(builder: (context, ref, child) {
        String val = ref.watch(hoverProvider);
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            width: widget.width ?? null,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: AppClass().getMqHeight(context) * 0.07,
                  height: AppClass().getMqHeight(context) * 0.03,
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.none,
                    onTap: () async {
                      await launchUrl(Uri.parse("https://github.com/shahzaibhassan414"));
                    },
                    onHover: (bol) {
                      if (bol) {
                        ref.read(hoverProvider.notifier).state = "git";
                      } else {
                        ref.read(hoverProvider.notifier).state = "";
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SvgPicture.asset('assets/svg/github.svg', color: val == "git" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
                    ),
                  ),
                ),
                Container(
                  width: AppClass().getMqHeight(context) * 0.07,
                  height: AppClass().getMqHeight(context) * 0.03,
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.none,
                    onTap: () async {
                      await launchUrl(Uri.parse("https://www.instagram.com/yaar_shiekh/?hl=en"));
                    },
                    onHover: (bol) {
                      if (bol) {
                        ref.read(hoverProvider.notifier).state = "insta";
                      } else {
                        ref.read(hoverProvider.notifier).state = "";
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SvgPicture.asset('assets/svg/instagram.svg', color: val == "insta" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
                    ),
                  ),
                ),
                Container(
                  width: AppClass().getMqHeight(context) * 0.07,
                  height: AppClass().getMqHeight(context) * 0.03,
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.none,
                    onTap: () async {
                      await launchUrl(Uri.parse("https://www.linkedin.com/in/shahzaibhassan414/"));
                    },
                    onHover: (bol) {
                      if (bol) {
                        ref.read(hoverProvider.notifier).state = "linkedIn";
                      } else {
                        ref.read(hoverProvider.notifier).state = "";
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SvgPicture.asset('assets/svg/linkedIn.svg', color: val == "linkedIn" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
