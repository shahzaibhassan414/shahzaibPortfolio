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
    return Expanded(
        flex: 1,
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
                                  AppClass().openEmail("shahzaibhassan414@gmail.com");
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
                                  margin: EdgeInsets.only(bottom: val == "email" ? 5.0 : 0),
                                  child: Text(
                                    'shahzaibhassan414@gmail.com',
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: val == "email" ?
                                            AppColors().neonColor:
                                        AppColors().textColor,
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
