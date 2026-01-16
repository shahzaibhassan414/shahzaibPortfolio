import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/appClass.dart';

import '../../controller/generalController.dart';
import '../../resource/colors.dart';

class RightPane extends ConsumerStatefulWidget {
  const RightPane({Key? key}) : super(key: key);

  @override
  ConsumerState<RightPane> createState() => _RightPaneState();
}

class _RightPaneState extends ConsumerState<RightPane> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      String val = ref.watch(hoverProvider);
                      bool isHovered = val == "email";
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: InkWell(
                            onTap: () async {
                              AppClass().openEmail(AppClass.email);
                            },
                            onHover: (bol) {
                              ref.read(hoverProvider.notifier).state = bol ? "email" : "";
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              margin: EdgeInsets.only(bottom: isHovered ? 8.0 : 0),
                              child: Text(
                                AppClass.email,
                                style: TextStyle(
                                    letterSpacing: 1.5,
                                    color: isHovered
                                        ? AppColors().primaryRedColor
                                        : AppColors().textColor,
                                    fontSize: 14,
                                    fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
                                    fontFamily: 'sfmono'),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                )),
            Expanded(
                child: Container(
              width: 1,
              color: AppColors().textColor.withValues(alpha: 0.5),
            ))
          ],
        ));
  }
}
