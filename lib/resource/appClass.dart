import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:portfolio/model/experienceModel.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/resource/custom_images.dart';
import 'package:portfolio/resource/styles.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view/projects/projectWeb.dart';


enum ScreenType { mobile, tab, web }

class AppClass {
  static final AppClass _mAppClass = AppClass._internal();
  static BuildContext? lastContext;
  ScrollController controller = ScrollController();

  /* URL */
  static final resumeDownloadURL =
      '''https://drive.google.com/file/d/1ZhD0RvF2-rQYX8trAtMzGivGLetlB3hx/view?usp=sharing''';

  static final email = "shahzaibhassan414@gmail.com";
  static final phoneNumber = "+92 316 0984600";

  static final simmanUrl =
      '''https://play.google.com/store/apps/details?id=com.hk.trudoctor&hl=en ''';
  static final examConnectUrl = ''' ''';
  static final MaterialWorldUrl = ''' ''';
  static final pawPlayLoveUrl =
      '''https://play.google.com/store/apps/details?id=com.pawplaylove&hl=en''';
  static final seePakistanUrl = ''' ''';
  static final onSceneUrl =
      '''https://play.google.com/store/apps/details?id=com.singlesonscene&hl=en''';

  // static final gitHermarts = '''https://github.com/jeeva-HBK/SafeC19''';
  static final gitWtIot = '''https://github.com/jeeva-HBK/AutoChem''';
  static final gitAutoStabilizer =
      '''https://github.com/jeeva-HBK/AutoStabilizer''';
  static final gitPAT = '''https://github.com/jeeva-HBK/PAT''';

  // static final gitAVM = '''https://github.com/jeeva-HBK/SafeC19''';

  List<WorkModel> projectList = [
    WorkModel(
        projectTitle: "Simman",
        projectContent:
            "Simman is an innovative medical app that is designed to assist new doctors in checking vital signs such as blood pressure, heart rate, SPO2, and respiratory rate. This user-friendly app is ideal for medical professionals who are just starting out in their careers and may require additional support and guidance in patient monitoring",
        techs: ["Flutter", "Shared Preferences"]),
    WorkModel(
        projectTitle: "ExamConnect",
        projectContent:
            "ExamConnect revolutionizes medical education through its Flutter-based mobile app, seamlessly integrated with Firebase database technology, fostering collaborative learning among students. The app facilitates partner matching based on preferences, schedules, and subjects, while real-time messaging encourages insightful discussions. Study groups tailored to specific subjects enable effortless resource sharing, and flexible scheduling ensures efficient coordination. With a strong focus on security.",
        techs: [
          "Flutter",
          "Firebase Messaging",
          "MVVM",
        ]),
    WorkModel(
        projectTitle: "Material World",
        projectContent:
            '''Material World is a multi-vendor ecommerce application developed using Flutter, delivering a seamless and secure cross-platform shopping experience. Built as a collaborative marketplace, the app offers a wide range of products in a single ecosystem, integrates secure payment gateways with encrypted transactions, and provides a personalized shopping journey through user-based recommendations to enhance overall customer satisfaction.''',
        techs: ["REST APIs", "Shared Memory", "MVC"]),
    WorkModel(
        projectTitle: "Paw Play Love",
        projectContent:
            '''Paw Play Love is a community-driven app designed to connect pet owners through their shared love for animals. Beyond traditional dating, it fosters meaningful friendships, playdates, and social interactions for both pets and their owners. The platform provides a safe and welcoming space to bond over pet companionship, arrange meetups, and build lasting connections. Join Paw Play Love to enhance your pet’s life and be part of a community that truly values the special bond between pets and their owners.''',
        techs: [
          "Agile Methodologies",
              "REST APIs",
          "Shared Memory",
        ]),
    WorkModel(
        projectTitle: "See Pakistan",
        projectContent:
            '''The platform enables seamless activity and event schedule management, provides detailed startup profiles, speaker information, and a complete event rundown, while also offering built-in tools for attendee feedback collection and efficient startup evaluations, making event management and participation smooth and well-organized.''',
        techs: [
          "MVVM",
              "REST APIs",
          "Figma",
        ]),
    WorkModel(
        projectTitle: "On Scene",
        projectContent:
            '''On Scene is a location-aware mobile application designed to help users discover nearby people, check into interesting venues, and build meaningful connections for friendship, fun, or more. It offers effortless discovery through real-time check-ins, smooth matching via swipe, browse, and direct messaging features, and robust privacy controls to empower users to manage connections safely. The app addresses challenges like real-time location tracking, engaging matching flows, and user safety by implementing intuitive check-in mechanisms, seamless chat and profile interactions, and secure data practices. The result is a polished, accessible social platform that encourages exploration, fosters genuine connections, and prioritizes user privacy.''',
        techs: [
          "Google Maps",
              "IAP",
          "Firebase",
        ]),
  ];

  final List<Map<String, dynamic>> skills = [
    {"name": "Flutter", "value": 0.9},
    {"name": "Dart", "value": 0.8},
    {"name": "State Management", "value": 0.7},
    {"name": "Firebase", "value": 0.8},
    {"name": "API Integration", "value": 1.0},
    {"name": "Secure Authentication", "value": 0.85},
    {"name": "Push Notifications", "value": 0.8},
    {"name": "Real-time Updates", "value": 0.8},
    {"name": "Offline Support & Caching", "value": 0.75},
    {"name": "App Performance Optimization", "value": 0.75},
    {"name": "Payment Gateway", "value": 0.8},
    {"name": "In-app Subscriptions", "value": 0.7},
    {"name": "App Deployment", "value": 0.9},
    {"name": "App Store Optimization (ASO)", "value": 0.7},
    {"name": "Github", "value": 0.8},
    {"name": "UI/UX", "value": 0.85},
    {"name": "Clean Architecture", "value": 0.8},
    {"name": "Blockchain Integration", "value": 0.7}
  ];

  final List<Map<String, dynamic>> skillsImages = [
    {"image": CustomImages.skillsDart , "name": "Dart"},
    {"image": CustomImages.skillsFlutter , "name": "Flutter"},
    {"image": CustomImages.skillsGit , "name": "Git"},
    {"image": CustomImages.skillsAndroidStudio, "name": "Android Studio"},
    {"image": CustomImages.skillsAppStore, "name": "App Store"},
    {"image": CustomImages.skillsPlayStore, "name": "Play Store"},
    {"image": CustomImages.skillsFirebase, "name": "Firebase"},
    {"image": CustomImages.skillsRedux, "name": "Redux"},
    {"image": CustomImages.skillsGoogleMap, "name": "Google Map"},
    {"image": CustomImages.skillsKyc, "name": "KYC"},
    {"image": CustomImages.skillsRevenueCat, "name": "In-App Purchases"},
    {"image": CustomImages.skillsSharedPrefrence, "name": "Local Storage"},
    {"image": CustomImages.skillsSocialLogin, "name": "Social Authentication"},
    {"image": CustomImages.skillsStripe, "name": "Stripe"},
    {"image": CustomImages.skillsBlockChain, "name": "Blockchain Integration"},
    {"image": CustomImages.skillsPushNotification, "name": "Push Notification"},
    {"image": CustomImages.skillsWebSocket, "name": "Socket IO"},
    {"image": CustomImages.skillsTanstack, "name": "Tanstack Query"},
    {"image": CustomImages.skillsFigma, "name": "Figma"},
  ];

  List<ProjectModel> projects = [
    ProjectModel(
      name: "Paw Play Love",
      image: CustomImages.projectPPl,
      description: "I developed Paw Play Love, a community-driven platform designed to connect pet owners through meaningful social interactions. On the technical side, I integrated Firebase Auth and Notifications, managed real-time communication using Sockets, and implemented RevenueCat for seamless in-app purchases and subscriptions. The app features a high-performance UI inspired by Figma designs, utilizing Cached Network Images and robust State Management to ensure a fluid user experience. From handling complex Deep Linking to precise Permission Handling, this project showcases my ability to build scalable, feature-rich mobile applications.",
      androidLink: "https://play.google.com/store/apps/details?id=com.pawplaylove&hl=en",
      iosLink: "https://apps.apple.com/id/app/paw-play-love/id6648773545",
    ),
    ProjectModel(
      name: "LawnOlu",
      description: "Developed Lawnolu, a high-performance service provider application leveraging REST APIs and Firebase (Notifications & Analytics). The app’s architecture supports multi-tenant logic, allowing users to switch between business roles seamlessly. Key technical achievements include implementing a real-time tracking system using Google Maps, managing state for complex service requests, and ensuring financial security through Stripe integration. By utilizing Sockets for real-time communication and optimizing the app for offline support, I delivered a reliable and responsive user experience even in low-connectivity environments",
      image: CustomImages.projectLawnolu,
    ),
    ProjectModel(
      name: "Zera",
      description: "Zera represents a masterclass in cross-functional app development, utilizing REST APIs and TanStack Query for robust state management and caching. I implemented specialized features including Custom Heat Maps for data visualization, QR Scanning for seamless interactions, and In-app Web Views for extended functionality. Technical challenges like cached filters, deep linking, and Firebase-driven notifications were solved to ensure a smooth, cross-device user journey. The architecture supports a diverse range of modules from community forums to secure e-commerce transactions.",
      image: CustomImages.projectZera,
    ),
    ProjectModel(
      name: "Simman",
      description: "With Simman, I tackled the complexities of Real-time Audio Streaming by building a robust architecture that balances speed with security. By integrating Firebase Realtime Database for live updates and implementing advanced State Management, I ensured the app remains responsive under heavy data loads. From Secure Authentication to fine-tuned Performance Optimization, every aspect of Simman was engineered to provide a top-tier user experience.",
      image: CustomImages.projectSimman,
    ),
    ProjectModel(
      name: "On Scene",
      description: "On Scene is a cutting-edge, location-aware social platform designed to bridge the gap between digital discovery and real-world connections. I engineered a seamless Check-in mechanism using Google Maps API, allowing users to discover and interact with others at nearby venues in real-time. To ensure high engagement, I integrated Socket-based real-time chat and a smooth matching system supported by RevenueCat for premium features. Addressing the critical challenge of user safety, I implemented robust Privacy & Control tools, including block/unblock features and secure data handling. The result is a polished, high-performance app that empowers users to build meaningful connections within a safe and intuitive environment.",
      image: CustomImages.projectOnScene,
    ),
    ProjectModel(
      name: "BePay Client",
      description: "Web3-Integrated Consumer Platform: I developed a high-end Flutter application for the end-user, focusing on a seamless transition between traditional and decentralized commerce. The app features a secure Web3 wallet creation and OAuth-based login to ensure a smooth onboarding experience. I implemented a robust Blockchain-based purchase system, allowing users to make secure transactions directly on the chain. To enhance usability, I integrated a smart cart with auto-save functionality, filter-based product listings, and a highly polished UI featuring custom animations and gradient schemes. The project involved rigorous KYC verification and real-time REST API integrations to provide a secure and modern shopping experience.",
      image: CustomImages.projectBePayClient,
    ),
    ProjectModel(
      name: "BePay Business",
      description: "I engineered a dedicated Flutter application for business owners and service providers within the Web3 ecosystem. This app manages complex KYB (Know Your Business) verification flows and provides tools for managing product listings and orders. A key highlight was the implementation of a secure business wallet for handling blockchain-based revenue and payouts. I worked closely with the client to manage rapid UI/UX iterations, adapting the login flows and management dashboards in short timeframes to meet evolving business needs. This app showcases my ability to handle enterprise-level security, complex state management, and direct coordination with stakeholders.",
      image: CustomImages.projectBePayBusiness,
    ),
    ProjectModel(
      name: "Jatt App",
      image: CustomImages.projectJatt,
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
      showIcon: false,
      title: Text(
        msg,
        style: TextStyle(
            fontFamily: 'sfmono',
            fontSize: 16,
            color: AppColors().textColor,
            fontWeight: FontWeight.w500),
      ),
      backgroundColor: AppColors().primaryRedColor,
      borderSide: BorderSide(color: AppColors().primaryRedColor),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  errorSnackBar(String msg, {BuildContext? context}) {
    toastification.show(
      context: context,
      showIcon: false,
      title: Text(
        msg,
        style: TextStyle(
            fontFamily: 'sfmono',
            fontSize: 16,
            color: AppColors().textColor,
            fontWeight: FontWeight.w500),
      ),
      backgroundColor: AppColors().primaryRedColor,
      borderSide: BorderSide(color: AppColors().primaryRedColor),
      autoCloseDuration: const Duration(seconds: 5),
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

  // Future<bool> sendEmail(String name, String contact, String msg) async {
  //   var url = Uri.parse('https://formspree.io/f/mvzpgaaq');
  //
  //   try {
  //     var response = await http
  //         .post(
  //           url,
  //           headers: {'Content-Type': 'application/json'},
  //           body: jsonEncode({"name": name, "email": contact, "message": msg}),
  //         )
  //         .timeout(const Duration(seconds: 10));
  //
  //     log("response.body");
  //     log(response.body);
  //     return response.statusCode == 200 || response.statusCode == 202;
  //   } catch (e) {
  //     print('Error sending email: $e');
  //     return false;
  //   }
  // }

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
            "time": DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
            'message': msg,
          }
        }),
      )
          .timeout(const Duration(seconds: 10));

      log("response.body");
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
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open WhatsApp for $phoneNumber';
    }
  }


}
