import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/Widgets/custom_cursor.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/splash/splash.dart';

void main() {
  runApp(ProviderScope(child: const AppTheme()));
}

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shahzaib Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors().backgroundColor,
        primaryColor: AppColors().primaryColor,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      builder: (context, child) {
        return CustomCursor(child: child!);
      },
      home: SplashContent(),
    );
  }
}
