import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/resource/responsive.dart';
import 'package:portfolio/view/contact/contactMobile.dart';
import 'package:portfolio/view/contact/contactTab.dart';
import 'package:portfolio/view/contact/contactWeb.dart';

class Contact extends ConsumerStatefulWidget {
  const Contact({super.key});

  @override
  ConsumerState<Contact> createState() => _ContactState();
}

class _ContactState extends ConsumerState<Contact> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      webView: const ContactWeb(),
      tabView: const ContactTab(),
      mobileView: const ContactMobile(),
    );
  }
}
