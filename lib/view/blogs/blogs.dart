import 'package:flutter/material.dart';

import '../../Widgets/blog_card.dart';
import '../../Widgets/main_title_widget.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 130 : 90,
        horizontal,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: 'Latest Blogs', isWeb: isWeb),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              'Practical notes on the implementation details behind polished Flutter products.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth >= 760
                  ? (constraints.maxWidth - 18) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: 18,
                runSpacing: 18,
                children: AppClass()
                    .blogs
                    .map(
                      (blog) => SizedBox(
                        width: width,
                        child: BlogCard(blog: blog),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
