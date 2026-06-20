import 'package:flutter/material.dart';

import '../resource/colors.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  final bool isWeb;

  const MainTitleWidget({
    super.key,
    required this.title,
    this.isWeb = true,
  });

  String get _index {
    const order = {
      'About Me': '01',
      'Experiences': '02',
      'Skills': '03',
      'Open Source Contributions': '04',
      'Open Source': '04',
      'My Projects': '05',
      'Latest Blogs': '06',
      "What's Next?": '07',
    };
    return order[title] ?? '•';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isWeb ? 48 : 32),
      child: Row(
        children: [
          Text(
            _index,
            style: TextStyle(
              color: AppColors().primaryColor,
              fontFamily: 'sfmono',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: TextStyle(
              color: AppColors().textColor,
              fontSize: isWeb ? 34 : 26,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors().dividerColor,
            ),
          ),
        ],
      ),
    );
  }
}
