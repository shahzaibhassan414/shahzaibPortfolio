import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/resource/custom_images.dart';
import 'package:portfolio/resource/styles.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/packageModel.dart';
import '../model/blogModel.dart';
import '../view/projects/projectWeb.dart';


enum ScreenType { mobile, tab, web }

class AppClass {
  static final AppClass _mAppClass = AppClass._internal();
  static BuildContext? lastContext;
  ScrollController controller = ScrollController();

  /* URL */
  static const resumeDownloadURL =
      '''https://drive.google.com/file/d/1ZhD0RvF2-rQYX8trAtMzGivGLetlB3hx/view?usp=sharing''';

  static const email = 'shahzaibhassan414@gmail.com';
  static const phoneNumber = '+92 316 0984600';

  List<PackageModel> packages = [
    PackageModel(
      name: 'fancy_button_animations',
      description: 'A Flutter package to add beautiful and interactive animations to buttons with minimal effort.',
      version: 'v0.0.2',
      pubLink: 'https://pub.dev/packages/fancy_button_animations',
      techs: ['Flutter', 'Dart', 'Animations']
    ),
    PackageModel(
      name: 'inner_curved_circle',
      description: 'A Flutter package that provides a widget to create a circle with an inner curved effect, perfect for custom UI designs.',
      version: 'v0.0.2',
      pubLink: 'https://pub.dev/packages/inner_curved_circle',
      techs: ['Flutter', 'Dart', 'UI Components']
    ),
  ];

  List<BlogModel> blogs = [
    BlogModel(
      title: 'How to Add a Heatmap in Flutter',
      description: 'Display a heatmap overlay on a Google Map using Flutter — showing data density such as user activity, locations, or hotspots.',
      imageUrl: 'https://images.unsplash.com/photo-1584291527935-456e8e2dd734?q=80&w=1925&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      link: 'https://midnight-grape-a6b.notion.site/Playbook-How-to-Add-a-Heatmap-in-Flutter-Google-Maps-2854fb3615b880538317ede1721ce16a',
      date: 'Oct 07, 2025'
    ),
    BlogModel(
      title: 'From SVG to Flutter Widget',
      description: 'The goal of this guide is to help Flutter developers turn any SVG design into a fully functional, customizable Flutter widget ',
      imageUrl: 'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?q=80&w=2344&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      link: 'https://midnight-grape-a6b.notion.site/Playbook-From-SVG-to-Flutter-Widget-2e94fb3615b880dd89a4fc2cc4d76f68',
      date: 'Jan 15, 2026'
    ),
  ];

  final List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'value': 0.9},
    {'name': 'Dart', 'value': 0.8},
    {'name': 'State Management', 'value': 0.7},
    {'name': 'REST API Integration', 'value': 1.0},
    {'name': 'Firebase', 'value': 0.8},
    {'name': 'Secure Authentication', 'value': 0.85},
    {'name': 'Push Notifications', 'value': 0.8},
    {'name': 'In-app Purchases & Subscriptions', 'value': 0.7},
    {'name': 'Offline Support & Caching', 'value': 0.7},
    {'name': 'Clean Architecture', 'value': 0.8},
    {'name': 'App Performance Optimization', 'value': 0.75},
    {'name': 'App Deployment', 'value': 0.9},
    {'name': 'Postman', 'value': 0.9},
    {'name': 'Payment Gateway', 'value': 0.8},
    {'name': 'App Store Optimization (ASO)', 'value': 0.7},
    {'name': 'Github', 'value': 0.8},
    {'name': 'UI/UX', 'value': 0.85},
    {'name': 'Blockchain Integration', 'value': 0.7}
  ];

  final List<Map<String, dynamic>> skillsImages = [
    {'image': CustomImages.skillsDart , 'name': 'Dart'},
    {'image': CustomImages.skillsFlutter , 'name': 'Flutter'},
    {'image': CustomImages.skillsGit , 'name': 'Git'},
    {'image': CustomImages.skillsAndroidStudio, 'name': 'Android Studio'},
    {'image': CustomImages.skillsAppStore, 'name': 'App Store'},
    {'image': CustomImages.skillsPlayStore, 'name': 'Play Store'},
    {'image': CustomImages.skillsFirebase, 'name': 'Firebase'},
    {'image': CustomImages.skillsRedux, 'name': 'Redux'},
    {'image': CustomImages.skillsGoogleMap, 'name': 'Google Map'},
    {'image': CustomImages.skillsKyc, 'name': 'KYC'},
    {'image': CustomImages.skillsRevenueCat, 'name': 'In-App Purchases'},
    {'image': CustomImages.skillsSharedPrefrence, 'name': 'Local Storage'},
    {'image': CustomImages.skillsSocialLogin, 'name': 'Social Authentication'},
    {'image': CustomImages.skillsStripe, 'name': 'Stripe'},
    {'image': CustomImages.skillsBlockChain, 'name': 'Blockchain Integration'},
    {'image': CustomImages.skillsPushNotification, 'name': 'Push Notification'},
    {'image': CustomImages.skillsWebSocket, 'name': 'Socket IO'},
    {'image': CustomImages.skillsTanstack, 'name': 'Tanstack Query'},
    {'image': CustomImages.skillsFigma, 'name': 'Figma'},
  ];

  List<ProjectModel> projects = [
    ProjectModel(
      name: 'Paw Play Love',
      image: CustomImages.projectPPl,
      description: 'I developed Paw Play Love, a community-driven platform designed to connect pet owners through meaningful social interactions. On the technical side, I integrated Firebase Auth and Notifications, managed real-time communication using Sockets, and implemented RevenueCat for seamless in-app purchases and subscriptions. The app features a high-performance UI inspired by Figma designs, utilizing Cached Network Images and robust State Management to ensure a fluid user experience.',
      androidLink: 'https://play.google.com/store/apps/details?id=com.pawplaylove&hl=en',
      iosLink: 'https://apps.apple.com/id/app/paw-play-love/id6648773545',
      techs: ['Flutter', 'Firebase', 'Socket.io', 'RevenueCat', 'Provider']
    ),
    ProjectModel(
      name: 'LawnOlu',
      description: 'Developed Lawnolu, a high-performance service provider application leveraging REST APIs and Firebase (Notifications & Analytics). The app’s architecture supports multi-tenant logic, allowing users to switch between business roles seamlessly. Key technical achievements include implementing a real-time tracking system using Google Maps, managing state for complex service requests, and ensuring financial security through Stripe integration.',
      image: CustomImages.projectLawnolu,
      techs: ['Flutter', 'REST API', 'Google Maps', 'Stripe', 'Socket.io']
    ),
    ProjectModel(
      name: 'Zera',
      description: 'Zera represents a masterclass in cross-functional app development, utilizing REST APIs and TanStack Query for robust state management and caching. I implemented specialized features including Custom Heat Maps for data visualization, QR Scanning for seamless interactions, and In-app Web Views for extended functionality.',
      image: CustomImages.projectZera,
      techs: ['Flutter', 'REST API', 'TanStack Query', 'Google Maps', 'QR Scanner']
    ),
    ProjectModel(
      name: 'Simman',
      description: 'With Simman, I tackled the complexities of Real-time Audio Streaming by building a robust architecture that balances speed with security. By integrating Firebase Realtime Database for live updates and implementing advanced State Management, I ensured the app remains responsive under heavy data loads.',
      image: CustomImages.projectSimman,
      techs: ['Flutter', 'Firebase Realtime DB', 'Audio Streaming', 'GetX']
    ),
    ProjectModel(
      name: 'On Scene',
      description: 'On Scene is a cutting-edge, location-aware social platform designed to bridge the gap between digital discovery and real-world connections. I engineered a seamless Check-in mechanism using Google Maps API, allowing users to discover and interact with others at nearby venues in real-time.',
      image: CustomImages.projectOnScene,
      techs: ['Flutter', 'Google Maps', 'Socket.io', 'RevenueCat', 'Firebase']
    ),
    ProjectModel(
      name: 'BePay Client',
      description: 'Web3-Integrated Consumer Platform: I developed a high-end Flutter application for the end-user, focusing on a seamless transition between traditional and decentralized commerce. The app features a secure Web3 wallet creation and OAuth-based login to ensure a smooth onboarding experience.',
      image: CustomImages.projectBePayClient,
      techs: ['Flutter', 'Web3Auth', 'Blockchain', 'REST API', 'KYC']
    ),
    ProjectModel(
      name: 'BePay Business',
      description: 'I engineered a dedicated Flutter application for business owners and service providers within the Web3 ecosystem. This app manages complex KYB (Know Your Business) verification flows and provides tools for managing product listings and orders.',
      image: CustomImages.projectBePayBusiness,
      techs: ['Flutter', 'Blockchain', 'KYB', 'REST API', 'Provider']
    ),
    ProjectModel(
      name: 'Jatt App',
      image: CustomImages.projectJatt,
      techs: ['Flutter', 'REST API', 'Firebase', 'Social Login']
    ),
  ];


  factory AppClass() {
    return _mAppClass;
  }

  AppClass._internal();

  getMqWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getMqHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  successSnackBar(String msg, {BuildContext? context}) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(
        'SYSTEM STATUS: SUCCESS',
        style: TextStyle(
            fontFamily: 'sfmono',
            fontWeight: FontWeight.bold,
            color: AppColors().primaryColor,
            fontSize: 12,
            letterSpacing: 1.5),
      ),
      description: Text(
        msg,
        style: TextStyle(
            fontFamily: 'sfmono',
            color: AppColors().textColor,
            fontSize: 13),
      ),
      alignment: Alignment.topRight,
      backgroundColor: AppColors().cardColor,
      primaryColor: AppColors().primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
    );
  }

  errorSnackBar(String msg, {BuildContext? context}) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(
        'SYSTEM ERROR',
        style: TextStyle(
            fontFamily: 'sfmono',
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
            fontSize: 12,
            letterSpacing: 1.5),
      ),
      description: Text(
        msg,
        style: TextStyle(
            fontFamily: 'sfmono',
            color: AppColors().textColor,
            fontSize: 13),
      ),
      alignment: Alignment.topRight,
      backgroundColor: AppColors().cardColor,
      primaryColor: Colors.redAccent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
    );
  }

  ScreenType getScreenType(BuildContext context) {
    double scrWidth = getMqWidth(context);
    if (scrWidth > 915) {
      return ScreenType.web;
    } else if (scrWidth < 650) {
      return ScreenType.mobile;
    }
    return ScreenType.tab;
  }

  downloadResume(context) async {
    await launchUrl(Uri.parse(AppClass.resumeDownloadURL));
  }

  alertDialog(context, title, msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(title, style: TxtStyle().boldWhite(context)),
                content: Text(msg),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Okay'))
                ]));
  }

  Future<bool> sendEmail(String name, String email, String msg) async {
    var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      var response = await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'origin': '*',
        },
        body: jsonEncode({
          'service_id': 'service_b9mvbxh',
          'template_id': 'template_dddn7kh',
          'user_id': 'ejm0mxBIecSEp7_vo',
          'template_params': {
            'from_name': name,
            'email': email,
            'time': DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
            'message': msg,
          }
        }),
      )
          .timeout(const Duration(seconds: 10));

      log('response.body');
      log(response.body);
      return response.statusCode == 200;
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }


  Future<void> openEmail(String email,) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email client';
    }
  }

  Future<void> openPhoneNumber(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open WhatsApp for $phoneNumber';
    }
  }


}
