import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/appClass.dart';

import '../../controller/generalController.dart';
import '../../resource/colors.dart';

class RightPane extends StatefulWidget {
  const RightPane({Key? key}) : super(key: key);

  @override
  State<RightPane> createState() => _RightPaneState();
}

class _RightPaneState extends State<RightPane> {
  @override
  Widget build(BuildContext context) {
    return SizedBox( // ✅ CHANGED: Removed Expanded
        width: 60,
        child: Container(
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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: RotatedBox(
                              quarterTurns: 1,
                              child: InkWell(
                                onTap: () async {
                                  AppClass().openEmail(AppClass.email);
                                },
                                onHover: (bol) {
                                  if (bol) {
                                    ref.read(hoverProvider.notifier).state =
                                        "email";
                                  } else {
                                    ref.read(hoverProvider.notifier).state = "";
                                  }
                                },
                                child: Container(
                                  child: Text(
                                    AppClass.email,
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: val == "email"
                                            ? AppColors().primaryRedColor
                                            : AppColors().textColor,
                                        fontSize: 14,
                                        fontFamily: 'sfmono'),
                                  ),
                                ),
                              )),
                        );
                      }),
                    ],
                  )),
              Expanded(
                  child: Container(
                width: 1,
                color: Colors.white,
              ))
            ],
          ),
        ));
  }
}
