import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Widgets/custom_social_icon.dart';
import '../../controller/generalController.dart';
import '../../resource/colors.dart';
import '../../resource/appClass.dart';

class Footer extends ConsumerWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrType = AppClass().getScreenType(context);
    final isMobile = scrType == ScreenType.mobile;

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textLink("Blog", "https://medium.com/@shahzaibhassan414"),
                const SizedBox(width: 20),
                _textLink("Newsletter", "https://medium.com/@shahzaibhassan414"),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "© 2024 Shahzaib Hassan. All rights reserved.",
              style: GoogleFonts.roboto(
                color: AppColors().textColor.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
      child: Column(
        children: [

          Divider(color: AppColors().primaryRedColor.withOpacity(0.3),),

          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Made with ❤️ by Shahzaib Hassan",
                      style: GoogleFonts.roboto(
                        color: AppColors().textColor.withValues(alpha: 0.5),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "© 2026. All rights reserved.",
                      style: GoogleFonts.roboto(
                        color: AppColors().textColor.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Center: Social Icons

              SocialIcons(),

              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Container(
              //       child: Consumer(builder: (context, ref, child) {
              //         String val = ref.watch(hoverProvider);
              //         return Padding(
              //           padding: const EdgeInsets.only(bottom: 15.0),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: [
              //               Container(
              //                 width: AppClass().getMqHeight(context) * 0.07,
              //                 child: InkWell(
              //                   onTap: () async {
              //                     await launchUrl(Uri.parse("https://github.com/shahzaibhassan414"));
              //                   },
              //                   onHover: (bol) {
              //                     if (bol) {
              //                       ref.read(hoverProvider.notifier).state = "git";
              //                     } else {
              //                       ref.read(hoverProvider.notifier).state = "";
              //                     }
              //                   },
              //                   child: Container(
              //                     margin: EdgeInsets.only(bottom: val == "git" ? 5.0 : 0),
              //                     padding: const EdgeInsets.only(bottom: 8.0),
              //                     child: SvgPicture.asset('assets/svg/github.svg', color: val == "git" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 width: AppClass().getMqHeight(context) * 0.07,
              //                 child: InkWell(
              //                   onTap: () async {
              //                     await launchUrl(Uri.parse("https://www.instagram.com/yaar_shiekh/?hl=en"));
              //                   },
              //                   onHover: (bol) {
              //                     if (bol) {
              //                       ref.read(hoverProvider.notifier).state = "insta";
              //                     } else {
              //                       ref.read(hoverProvider.notifier).state = "";
              //                     }
              //                   },
              //                   child: Container(
              //                     margin: EdgeInsets.only(bottom: val == "insta" ? 5.0 : 0),
              //                     padding: const EdgeInsets.only(bottom: 8.0),
              //                     child: SvgPicture.asset('assets/svg/instagram.svg', color: val == "insta" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 width: AppClass().getMqHeight(context) * 0.07,
              //                 height: AppClass().getMqHeight(context) * 0.03,
              //                 child: InkWell(
              //                   onTap: () async {
              //                     await launchUrl(Uri.parse("https://www.linkedin.com/in/shahzaibhassan414/"));
              //                   },
              //                   onHover: (bol) {
              //                     if (bol) {
              //                       ref.read(hoverProvider.notifier).state = "linkedIn";
              //                     } else {
              //                       ref.read(hoverProvider.notifier).state = "";
              //                     }
              //                   },
              //                   child: Container(
              //                     padding: const EdgeInsets.only(bottom: 8.0),
              //                     child: SvgPicture.asset('assets/svg/linkedIn.svg', color: val == "linkedIn" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
              //                   ),
              //                 ),
              //               ),
              //               // Container(
              //               //   height: AppClass().getMqHeight(context) * 0.07,
              //               //   child: InkWell(
              //               //     onTap: () {},
              //               //     onHover: (bol) {
              //               //       if (bol) {
              //               //         ref.read(hoverProvider.notifier).state = "twitter";
              //               //       } else {
              //               //         ref.read(hoverProvider.notifier).state = "";
              //               //       }
              //               //     },
              //               //     child: Container(
              //               //       margin: EdgeInsets.only(bottom: val == "twitter" ? 5.0 : 0),
              //               //       padding: const EdgeInsets.only(bottom: 8.0),
              //               //       child: SvgPicture.asset('assets/svg/twitter.svg', color: val == "twitter" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
              //               //     ),
              //               //   ),
              //               // ),
              //               // Container(
              //               //   height: AppClass().getMqHeight(context) * 0.07,
              //               //   child: InkWell(
              //               //     onTap: () async {
              //               //       await launchUrl(Uri.parse("https://stackoverflow.com/users/19705360/mr-jeeva"));
              //               //     },
              //               //     onHover: (bol) {
              //               //       if (bol) {
              //               //         ref.read(hoverProvider.notifier).state = "stackoverflow";
              //               //       } else {
              //               //         ref.read(hoverProvider.notifier).state = "";
              //               //       }
              //               //     },
              //               //     child: Container(
              //               //       margin: EdgeInsets.only(bottom: val == "stackoverflow" ? 5.0 : 0),
              //               //       padding: const EdgeInsets.only(bottom: 8.0),
              //               //       child: SvgPicture.asset('assets/svg/stackoverflow.svg', color: val == "stackoverflow" ? AppColors().primaryRedColor : AppColors().textColor, width: 22),
              //               //     ),
              //               //   ),
              //               // ),
              //             ],
              //           ),
              //         );
              //       }),
              //     ),
              //     // _socialIcon('assets/svg/github.svg', 'https://github.com/shahzaibhassan414'),
              //     // const SizedBox(width: 25),
              //     // _socialIcon('assets/svg/instagram.svg', 'https://www.instagram.com/yaar_shiekh/?hl=en'),
              //     // const SizedBox(width: 25),
              //     // _socialIcon('assets/svg/linkedIn.svg', 'https://www.linkedin.com/in/shahzaibhassan414/'),
              //   ],
              // ),

              // Right: Blog & Newsletter
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // todo to be added later
                    // _textLink("Blog", ""),
                    // const SizedBox(width: 25),
                    // _textLink("Newsletter", "https://medium.com/@shahzaibhassan414"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textLink(String label, String url) {
    return Consumer(builder: (context, ref, child) {
      String val = ref.watch(hoverProvider);
      return InkWell(
        onTap: () async {
          if(url.isNotEmpty) {
            await launchUrl(Uri.parse(url));
          }
        },
        onHover: (bol) {
          if (bol) {
            ref.read(hoverProvider.notifier).state = label;
          } else {
            ref.read(hoverProvider.notifier).state = "";
          }
        },
        child: Text(
          label,
          style: GoogleFonts.roboto(
            color: val == label ? AppColors().primaryRedColor  : AppColors().textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}
