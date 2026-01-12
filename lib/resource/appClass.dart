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
    {"name": "API Integration", "value": 1.0},
    {"name": "Deployment", "value": 0.9},
    {"name": "UI/UX", "value": 0.85},
    {"name": "State Management", "value": 0.7},
    {"name": "Github", "value": 0.8},
    {"name": "Problem Solving", "value": 0.8},
    {"name": "Team Work", "value": 0.7},
    {"name": "Communication", "value": 0.69},
    {"name": "Clean Code", "value": 0.8},
  ];

  final List<Map<String, dynamic>> skillsImages = [
    {"image": CustomImages.skillsFlutter , "name": "Flutter"},
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
    {"image": CustomImages.skillsWeb3, "name": "Web 3"},
    {"image": CustomImages.skillsPushNotification, "name": "Push Notification"},
    {"image": CustomImages.skillsWebSocket, "name": "Web Socket"},
  ];

  List<ProjectModel> projects = [
    ProjectModel(
      name: "Paw Play Love",
      image: CustomImages.projectPPl,
      description: "",
      androidLink: "https://play.google.com/store/apps/details?id=com.pawplaylove&hl=en",
      iosLink: "https://apps.apple.com/id/app/paw-play-love/id6648773545",
    ),
    ProjectModel(
      name: "LawnOlu",
      image: CustomImages.projectLawnolu,
    ),
    ProjectModel(
      name: "Zera",
      image: CustomImages.projectZera,
    ),
    ProjectModel(
      name: "Simman",
      image: CustomImages.projectSimman,
    ),
    ProjectModel(
      name: "On Scene",
      image: CustomImages.projectOnScene,
    ),
    ProjectModel(
      name: "BePay Client",
      image: CustomImages.projectBePayClient,
    ),
    ProjectModel(
      name: "BePay Business",
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


  Future<void> openEmail(String email, {String subject = '', String body = ''}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email client';
    }
  }


}
