import 'package:flutter/material.dart';
import '../../Widgets/main_title_widget.dart';
import '../../Widgets/blog_card.dart';
import '../../resource/appClass.dart';

class BlogsWeb extends StatelessWidget {
  const BlogsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = AppClass().blogs;
    final mqWidth = AppClass().getMqWidth(context);

    return Container(
      width: mqWidth,
      margin: EdgeInsets.only(
        top: mqWidth * 0.1,
        left: mqWidth * 0.03,
        right: mqWidth * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitleWidget(title: 'Latest Blogs'),
          const SizedBox(height: 40),
          Center(
            child: Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: blogs.map((blog) => BlogCard(blog: blog)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
