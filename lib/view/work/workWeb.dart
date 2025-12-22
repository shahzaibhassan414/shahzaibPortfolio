import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resource/colors.dart';

class WorkWeb extends ConsumerStatefulWidget {
  const WorkWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<WorkWeb> createState() => _WorkWebState();
}

class _WorkWebState extends ConsumerState<WorkWeb> {
  @override
  Widget build(BuildContext context) {
    int crossAxisCount = getCrossAxisCount(context);

    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: "03.",
            style: TextStyle(
                color: AppColors().neonColor, fontSize: 20, fontFamily: 'sfmono'),
            children: <TextSpan>[
              TextSpan(
                text: ' My Projects',
                style: GoogleFonts.roboto(
                    color: AppColors().textColor,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'View my projects',
            style: TextStyle(
                color: AppColors().neonColor, fontSize: 15, fontFamily: 'sfmono'),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30.0, bottom: 70.0),
          child: StaggeredGrid.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(AppClass().projectList.length, (index) {
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: getTile(index: index),
              );
            }),
          ),
        ),
      ],
    );
  }

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) return 1; // mobile
    if (width < 900) return 2; // tablet
    return 3;
  }

  getTile({required int index}) {
    return InkWell(
      onTap: () async {
        switch (index) {
          case 0:
            await launchUrl(Uri.parse(AppClass.simmanUrl));
            break;
          case 1:
          case 2:
          case 4:
            AppClass().alertDialog(
                context, 'Not Found', 'Sorry the project you requested not found');
            break;
          case 3:
            await launchUrl(Uri.parse(AppClass.pawPlayLoveUrl));
            break;
          case 5:
            await launchUrl(Uri.parse(AppClass.onSceneUrl));
            break;
        }
      },
      onHover: (hovering) {
        if (hovering) {
          ref.read(hoverProvider.notifier).state = "$index";
        } else {
          ref.read(hoverProvider.notifier).state = "";
        }
      },
      child: Consumer(builder: (context, ref, child) {
        String data = ref.watch(hoverProvider);
        bool isHovered = (data == "$index");

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: isHovered
              ? (Matrix4.identity()
            ..translate(0.0, -8.0)
            ..scale(1.03))
              : Matrix4.identity(),
          child: Card(
            elevation: isHovered ? 18 : 10,
            shadowColor: AppColors().neonColor.withOpacity(0.4),
            color: AppColors().cardColor,
            // elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/folder.svg',
                        width: 45,
                        height: 45,
                        color: isHovered ?
                            AppColors().textColor :
                        AppColors().neonColor,
                      ),
                      SvgPicture.asset(
                        'assets/svg/externalLink.svg',
                        width: 22,
                        height: 22,
                        color: isHovered ? AppColors().neonColor : Colors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppClass().projectList[index].projectTitle.toString(),
                      style: GoogleFonts.robotoSlab(
                        color: isHovered ? AppColors().neonColor : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    AppClass().projectList[index].projectContent.toString(),
                    style: GoogleFonts.roboto(
                      color: AppColors().textLight,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  if(AppClass()
                      .projectList[index].techs!.isNotEmpty)
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: AppClass()
                        .projectList[index]
                        .techs!
                        .map(
                          (tech) => Text(
                        tech ,
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          fontSize: 12,
                        ),
                      ),
                    )
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
