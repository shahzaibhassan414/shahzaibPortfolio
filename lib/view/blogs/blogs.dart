import 'package:flutter/material.dart';
import '../../resource/responsive.dart';
import 'blogsWeb.dart';

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Responsive(
      webView: const BlogsWeb(),
      tabView: const BlogsWeb(),
      mobileView: const BlogsWeb(),
    );
  }
}
