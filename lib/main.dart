import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/root.dart';

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
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors().backgroundColor,
        primaryColor: AppColors().primaryColor,
        colorScheme: ColorScheme.dark(
          primary: AppColors().primaryColor,
          surface: AppColors().cardColor,
          onSurface: AppColors().textColor,
        ),
        fontFamily: 'Arial',
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const RootScreen(),
    );
  }
}
