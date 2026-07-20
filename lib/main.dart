import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/projects/project_detail_view.dart';
import 'package:portfolio/view/root.dart';

void main() {
  runApp(const ProviderScope(child: AppTheme()));
}

class AppTheme extends StatelessWidget {
  const AppTheme({super.key});

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
      // Set initial route
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Handle Home
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const RootScreen());
        }

        // Handle Project Details: /project/project-name
        if (settings.name!.startsWith('/project/')) {
          final projectName = settings.name!.replaceFirst('/project/', '').replaceAll('-', ' ');
          
          // Find the project by name (case-insensitive)
          final project = AppClass().projects.firstWhere(
            (p) => p.name.toLowerCase() == projectName.toLowerCase(),
            orElse: () => AppClass().projects.first,
          );

          return MaterialPageRoute(
            settings: settings, // This ensures the URL updates in the browser
            builder: (context) => ProjectDetailView(project: project),
          );
        }

        return null;
      },
    );
  }
}
