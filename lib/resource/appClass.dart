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
      '''https://drive.google.com/file/d/1NoEbEf10bPoYPQt8yiaMGpaGDvDXYP5P/view?usp=sharing''';

  static const email = 'shahzaibhassan414@gmail.com';
  static const phoneNumber = '+92 316 0984600';

  List<PackageModel> packages = [
    PackageModel(
        name: 'fancy_button_animations',
        description:
            'A Flutter package to add beautiful and interactive animations to buttons with minimal effort.',
        version: 'v0.0.2',
        pubLink: 'https://pub.dev/packages/fancy_button_animations',
        techs: ['Flutter', 'Dart', 'Animations']),
    PackageModel(
        name: 'inner_curved_circle',
        description:
            'A Flutter package that provides a widget to create a circle with an inner curved effect, perfect for custom UI designs.',
        version: 'v0.0.2',
        pubLink: 'https://pub.dev/packages/inner_curved_circle',
        techs: ['Flutter', 'Dart', 'UI Components']),
  ];

  List<BlogModel> blogs = [
    BlogModel(
        title: 'How to Add a Heatmap in Flutter',
        description:
            'Display a heatmap overlay on a Google Map using Flutter — showing data density such as user activity, locations, or hotspots.',
        imageUrl:
            'https://images.unsplash.com/photo-1584291527935-456e8e2dd734?q=80&w=1925&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        link:
            'https://midnight-grape-a6b.notion.site/Playbook-How-to-Add-a-Heatmap-in-Flutter-Google-Maps-2854fb3615b880538317ede1721ce16a',
        date: 'Oct 07, 2025'),
    BlogModel(
        title: 'From SVG to Flutter Widget',
        description:
            'The goal of this guide is to help Flutter developers turn any SVG design into a fully functional, customizable Flutter widget ',
        imageUrl:
            'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?q=80&w=2344&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        link:
            'https://midnight-grape-a6b.notion.site/Playbook-From-SVG-to-Flutter-Widget-2e94fb3615b880dd89a4fc2cc4d76f68',
        date: 'Jan 15, 2026'),
  ];

  List<Map<String, dynamic>> skills = [
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

  List<Map<String, dynamic>> skillsImages = [
    {'image': CustomImages.skillsDart, 'name': 'Dart'},
    {'image': CustomImages.skillsFlutter, 'name': 'Flutter'},
    {'image': CustomImages.skillsGit, 'name': 'Git'},
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
      description:
          'I developed Paw Play Love, a community-driven platform designed to connect pet owners through meaningful social interactions. On the technical side, I integrated Firebase Auth and Notifications, managed real-time communication using Sockets, and implemented RevenueCat for seamless in-app purchases and subscriptions. The app features a high-performance UI inspired by Figma designs, utilizing Cached Network Images and robust State Management to ensure a fluid user experience.',
      role: 'Flutter developer',
      timeline: 'Social product',
      impact: 'Subscriptions + real-time community',
      androidLink:
          'https://play.google.com/store/apps/details?id=com.pawplaylove&hl=en',
      iosLink: 'https://apps.apple.com/id/app/paw-play-love/id6648773545',
      techs: ['Flutter', 'Firebase', 'Socket.io', 'RevenueCat', 'Provider'],
      highlights: [
        'Built a swipe-based social discovery experience for pet owners to find matches, playdates, and nearby pet lovers.',
        'Implemented real-time chat, match updates, and social interactions using socket-driven communication.',
        'Integrated RevenueCat subscriptions, Boosts, Super Likes, Rewinds, and premium access across iOS and Android.',
      ],
      technicalDecisions: [
        'Used Provider for lightweight state management to keep the UI reactive without adding unnecessary architectural complexity.',
        'Implemented Socket.io for real-time chat and match-related updates, reducing the need for frequent API polling.',
        'Adopted RevenueCat to manage cross-platform subscription logic, entitlement checks, and store-side purchase handling.',
      ],
    ),
    ProjectModel(
      name: 'Simman',
      description:
          'With Simman, I tackled the complexities of Real-time Audio Streaming by building a robust architecture that balances speed with security. By integrating Firebase Realtime Database for live updates and implementing advanced State Management, I ensured the app remains responsive under heavy data loads.',
      image: CustomImages.projectSimman,
      role: 'Realtime systems developer',
      timeline: 'Medical simulation platform',
      impact: 'Low-latency realtime simulation UX',
      techs: ['Flutter', 'Firebase Realtime DB', 'Audio Streaming', 'GetX'],
      highlights: [
        'Built real-time audio streaming flows for live medical simulation sessions.',
        'Implemented Firebase Realtime Database syncing for instant instructor-to-student updates.',
        'Created responsive simulation screens that remained stable during continuous realtime data changes.',
      ],
      technicalDecisions: [
        'Used GetX for lightweight dependency injection and reactive state handling across realtime simulation screens.',
        'Selected Firebase Realtime Database over Firestore to support faster synchronization for live control and audio state updates.',
        'Structured audio and realtime listeners carefully to reduce UI lag during active simulation sessions.',
      ],
    ),
    ProjectModel(
      name: 'BePay Client',
      description:
          'BePay Client is a Web3-enabled consumer commerce app built in Flutter, designed to make blockchain-based payments and wallet onboarding simple for everyday users. I implemented social login-based wallet creation, REST API integrations, KYC flows, and secure handling of wallet-related data to create a smooth bridge between traditional commerce and decentralized finance.',
      image: CustomImages.projectBePayClient,
      role: 'Web3 consumer app developer',
      timeline: 'Web3 commerce platform',
      impact: 'Simplified wallet onboarding + KYC',
      techs: ['Flutter', 'Web3Auth', 'Blockchain', 'REST API', 'KYC'],
      highlights: [
        'Built social login-based wallet creation using Web3Auth to simplify Web3 onboarding.',
        'Integrated REST API flows with blockchain-backed commerce features for a hybrid Web2/Web3 experience.',
        'Developed KYC-oriented screens to support user verification and secure platform access.',
      ],
      technicalDecisions: [
        'Used Web3Auth to reduce Web3 onboarding friction by allowing users to create wallets through familiar OAuth login flows.',
        'Applied a repository-based structure to separate Web2 REST API logic from Web3 wallet and blockchain-related operations.',
        'Stored sensitive wallet-related metadata securely on-device to protect user session and authentication data.',
      ],
    ),
    ProjectModel(
      name: 'BePay Business',
      description:
          'BePay Business is a merchant-facing Flutter application built for business owners and service providers operating inside a Web3 commerce ecosystem. I developed KYB onboarding flows, product and listing management, and order operation tools to help merchants verify their businesses and manage commerce activity from a dedicated mobile platform.',
      image: CustomImages.projectBePayBusiness,
      role: 'Merchant app developer',
      timeline: 'Web3 merchant platform',
      impact: 'KYB onboarding + order operations',
      techs: ['Flutter', 'Blockchain', 'KYB', 'REST API', 'Provider'],
      highlights: [
        'Built merchant-facing search/filter tools for managing products, listings, and customer orders.',
        'Implemented multi-step KYB verification flows for business onboarding and compliance.',
        'Created operational screens that helped merchants manage Web3 commerce activity from mobile.',
      ],
      technicalDecisions: [
        'Used Provider to manage complex merchant state across KYB, product, listing, and order management flows.',
        'Designed a multi-step dynamic KYB form structure to support flexible business verification requirements.',
        'Optimized listing and order screens with pagination-ready data handling for scalable merchant operations.',
      ],
    ),
    ProjectModel(
      name: 'On Scene',
      description:
          'On Scene is a location-aware dating and social discovery app built to help users connect with people around real-world venues, events, and nearby places. I worked on the check-in experience, Google Maps integration, live presence updates, and premium subscription flows to bridge digital discovery with real-life connections.',
      image: CustomImages.projectOnScene,
      role: 'Location feature lead',
      timeline: 'Venue-based dating app',
      impact: 'Live discovery + real-world connections',
      isFeatured: true,
      techs: ['Flutter', 'Google Maps', 'Socket.io', 'RevenueCat', 'Firebase'],
      highlights: [
        'Built venue-based check-in flows that allowed users to discover and interact with nearby people.',
        'Integrated Google Maps, Socket.io, and Firebase to power live location-aware discovery.',
        'Implemented RevenueCat subscriptions to support premium dating and discovery experiences.',
      ],
      technicalDecisions: [
        'Used Google Maps to create a venue-first discovery experience instead of relying only on traditional swipe-based matching.',
        'Connected socket events with map-based user presence to keep nearby activity updated in real time.',
        'Adopted RevenueCat to manage subscription access and premium feature availability across iOS and Android.',
      ],
      caseStudy: [
        CaseStudyStep(
          title: 'Overview',
          description: 'On Scene is a location-aware dating and social discovery app designed to help users connect with people around real-world venues, events, and nearby places. Instead of relying only on traditional swipe-based discovery, the app focuses on live presence, check-ins, and real-world social interactions.',
        ),
        CaseStudyStep(
          title: 'My Role',
          description: 'I worked as the Main Flutter Developer, responsible for building the core mobile app experience across Android and iOS. My work included location-based discovery, Google Maps integration, check-in flows, real-time presence updates, Firebase services, Socket.io integration, RevenueCat subscriptions, and production-ready mobile implementation.',
        ),
        CaseStudyStep(
          title: 'Problem',
          description: 'The app needed to connect digital dating with real-world discovery. Users needed to see nearby activity, check in to venues, discover people around them, and interact through a location-aware experience. The challenge was combining maps, location data, real-time updates, and premium features into one smooth mobile experience.',
        ),
        CaseStudyStep(
          title: 'What I Built',
          description: 'I built venue-based check-in flows that allowed users to discover and interact with nearby people. I integrated Google Maps for location-aware discovery, Socket.io for real-time presence updates, Firebase for notifications and engagement features, and RevenueCat for premium subscription access across iOS and Android.',
        ),
        CaseStudyStep(
          title: 'Technical Decisions',
          description: 'I used Google Maps to create a venue-first discovery experience, making the app feel connected to real-world places instead of only profile browsing. Socket.io was used to keep nearby activity and user presence updated in real time. RevenueCat was integrated to simplify subscription handling, entitlement checks, and premium feature access across both app stores.',
        ),
        CaseStudyStep(
          title: 'Challenges',
          description: 'One of the key challenges was keeping map-based discovery responsive while handling user presence, venue check-ins, and live updates. Map-heavy screens can become slow if markers, location updates, and socket events are not managed carefully. I structured the location and real-time update logic to keep the discovery experience smooth and reliable.',
        ),
        CaseStudyStep(
          title: 'Outcome',
          description: 'On Scene became a real-world social discovery platform that combines location, live presence, check-ins, and premium dating features. The app helped users move beyond traditional matching by connecting around real venues and nearby activity.',
        ),
      ],
    ),
    ProjectModel(
      name: 'LawnOlu',
      description:
          'LawnOlu is an on-demand lawn-care service marketplace that connects customers with trusted service providers. The app allows customers to book lawn-care services, track active jobs, manage payments, receive updates, and communicate with service providers through a structured mobile experience.',
      image: CustomImages.projectLawnolu,
      role: 'Mobile app engineer',
      timeline: 'On-demand service marketplace',
      impact: 'Bookings + live tracking + payments',
      isFeatured: true,
      techs: ['Flutter', 'REST API', 'Google Maps', 'Stripe', 'Socket.io'],
      highlights: [
        'Built customer and provider flows for booking, managing, and completing lawn-care service requests.',
        'Implemented Google Maps-based live tracking for active jobs and provider movement.',
        'Integrated Stripe, Firebase notifications, and analytics to support payments, updates, and usage tracking.',
      ],
      technicalDecisions: [
        'Designed a role-based navigation and state structure so one Flutter codebase could support both customers and service providers.',
        'Used Google Maps polylines and location updates to visualize provider routes and active job progress in real time.',
        'Integrated Stripe to handle secure in-app payments while keeping payment logic separated from service booking flows.',
      ],
      caseStudy: [
        CaseStudyStep(
          title: 'Overview',
          description: 'LawnOlu is an on-demand lawn-care service marketplace that connects customers with trusted service providers. The app allows customers to book lawn-care services, track active jobs, manage payments, receive updates, and communicate with service providers through a structured mobile experience.',
        ),
        CaseStudyStep(
          title: 'My Role',
          description: 'I worked as the Main Flutter Developer, responsible for building the core mobile application experience for both customers and service providers. My work included multi-role app flows, service request handling, REST API integration, Google Maps tracking, Stripe payment flows, Firebase notifications, analytics support, and job lifecycle screens.',
        ),
        CaseStudyStep(
          title: 'Problem',
          description: 'The app needed to support two different user types within one codebase: customers and service providers. Customers needed a simple way to book and track services, while providers needed tools to manage requests, view job details, update availability, and complete service operations. The challenge was keeping these flows separate where needed while still maintaining one scalable Flutter project.',
        ),
        CaseStudyStep(
          title: 'What I Built',
          description: 'I built customer and provider flows for booking, managing, and completing lawn-care jobs. I implemented Google Maps-based live tracking for active service requests, integrated Stripe for secure payment handling, connected Firebase notifications for job updates, and worked with REST APIs to manage bookings, profiles, services, and operational data.',
        ),
        CaseStudyStep(
          title: 'Technical Decisions',
          description: 'I designed a role-based navigation and state structure so the same Flutter codebase could support both customer and provider experiences. For live tracking, I used Google Maps, location updates, markers, and polylines to visualize provider movement and job progress. I also kept payment-related logic separate from booking logic to make the Stripe integration easier to maintain and extend.',
        ),
        CaseStudyStep(
          title: 'Challenges',
          description: 'A major challenge was managing the complete job lifecycle across different roles. Customers and providers needed different screens, actions, and status updates for the same service request. Real-time map updates, payment handling, job details, and notifications also had to work together without making the app feel heavy or confusing.',
        ),
        CaseStudyStep(
          title: 'Outcome',
          description: 'LawnOlu delivered a complete on-demand service marketplace experience with booking, tracking, payments, notifications, and provider operations. The role-based structure made the app scalable while allowing both customers and service providers to use the platform from one Flutter application.',
        ),
      ],
    ),
    ProjectModel(
      name: 'Zera',
      description:
          'Zera is a multi-vertical marketplace app built in Flutter that brings jobs, goods, services, events, and community features into one unified platform. I worked on data-heavy marketplace flows including demand heat maps, QR ticket workflows, in-app web views, server-state caching with TanStack Query, and location-based experiences to support a smooth buy, sell, work, and connect experience.',
      image: CustomImages.projectZera,
      role: 'Marketplace feature developer',
      timeline: 'Multi-vertical marketplace',
      impact: 'Heatmaps + QR workflows + server-state caching',
      isFeatured: true,
      techs: [
        'Flutter',
        'REST API',
        'TanStack Query',
        'Google Maps',
        'QR Scanner'
      ],
      highlights: [
        'Built marketplace features across jobs, goods, services, events, and community modules.',
        'Implemented demand heat map views to help users discover location-based activity and opportunities.',
        'Added QR ticket scanning, in-app web views, and cached API flows for faster user actions.',
      ],
      technicalDecisions: [
        'Used TanStack Query for server-state management, caching, refetching, and predictable API-driven UI updates.',
        'Designed Google Maps-based heat map flows to visualize high-density marketplace activity without overloading the UI.',
        'Implemented modular QR scanning and in-app web view handling to support event tickets, external flows, and dynamic actions.',
      ],
      caseStudy: [
        CaseStudyStep(
          title: 'Overview',
          description: 'Zera is a multi-vertical marketplace application that brings jobs, goods, services, events, and community features into one mobile platform. The app is designed to help users buy and sell goods, discover job opportunities, offer or book services, explore events, purchase tickets, and connect through community posts.',
        ),
        CaseStudyStep(
          title: 'My Role',
          description: 'I worked as the Main Flutter Developer, responsible for building and maintaining the core mobile app experience across multiple modules. My responsibilities included feature development, API integration, state management, QR workflows, map-based features, server-state caching, UI implementation, and production-ready mobile delivery.',
        ),
        CaseStudyStep(
          title: 'Problem',
          description: 'The main challenge was building a single app that could support several different marketplace experiences without making the app feel complex or slow. Each module had its own data structure, user flow, and backend behavior, so the mobile architecture needed to stay scalable and easy to maintain.',
        ),
        CaseStudyStep(
          title: 'What I Built',
          description: 'I worked on core marketplace flows across jobs, goods, services, events, and community modules. I also implemented demand heat map views for location-based insights, QR ticket scanning for event workflows, in-app web views for extended functionality, and cached API flows to make the app feel faster and more reliable.',
        ),
        CaseStudyStep(
          title: 'Technical Decisions',
          description: 'I used TanStack Query to manage server-state, API caching, refetching, and predictable UI updates. This helped reduce unnecessary API calls and kept data-heavy screens more stable. For location-based experiences, I integrated Google Maps and implemented heat map-style views to visualize high-density marketplace activity. I also kept QR scanning and in-app web view handling modular so they could support multiple workflows across the app.',
        ),
        CaseStudyStep(
          title: 'Challenges',
          description: 'One of the biggest challenges was managing different modules inside one consistent user experience. Jobs, goods, services, events, and community posts all required different API responses, forms, filters, and UI states. I handled this by keeping API logic, reusable components, and feature-specific flows organized so the app could scale without becoming difficult to maintain.',
        ),
        CaseStudyStep(
          title: 'Outcome',
          description: 'Zera became a feature-rich marketplace platform with multiple user journeys inside one Flutter app. The final implementation supported smooth API-driven interactions, location-based discovery, QR workflows, and a scalable structure for future marketplace expansion.',
        ),
      ],
    ),
    ProjectModel(
      name: 'Jatt App',
      image: CustomImages.projectJatt,
      description:
          'Jatt App is a Flutter-based social application focused on smooth onboarding, secure authentication, social login, and Firebase-backed engagement flows. I worked on authenticated REST API integration, clean mobile UI screens, and the foundation needed to support future social features as the product scales.',
      role: 'Flutter app developer',
      timeline: 'Social networking app',
      impact: 'Auth + social engagement foundation',
      techs: ['Flutter', 'REST API', 'Firebase', 'Social Login'],
      highlights: [
        'Built social login and authenticated REST API flows for user onboarding.',
        'Integrated Firebase-backed services to support user engagement and app communication flows.',
        'Created a clean, scalable mobile UI foundation for future social networking features.',
      ],
      technicalDecisions: [
        'Structured authentication and API layers separately from UI to keep the codebase easier to maintain and extend.',
        'Used Dio interceptors to manage authenticated requests and handle token-based API communication smoothly.',
        'Kept Firebase integration modular so engagement features could be expanded without tightly coupling them to screens.',
      ],
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
      title: const Text(
        'SYSTEM STATUS: SUCCESS',
        style: TextStyle(
            fontFamily: 'sfmono',
            fontWeight: FontWeight.bold,
            color: Color(0xFF64FFDA),
            fontSize: 12,
            letterSpacing: 1.5),
      ),
      description: Text(
        msg,
        style: TextStyle(
            fontFamily: 'sfmono', color: AppColors().textColor, fontSize: 13),
      ),
      alignment: Alignment.topRight,
      backgroundColor: AppColors().cardColor,
      primaryColor: const Color(0xFF64FFDA),
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
      title: const Text(
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
            fontFamily: 'sfmono', color: AppColors().textColor, fontSize: 13),
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
                      child: const Text('Okay'))
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

  Future<void> openEmail(
    String email,
  ) async {
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
