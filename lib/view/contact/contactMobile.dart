import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/resource/appClass.dart';

import '../../Widgets/custom_contact_card.dart';
import '../../Widgets/custom_hover_button.dart';
import '../../Widgets/main_title_widget.dart';
import '../../controller/generalController.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';

class ContactMobile extends ConsumerStatefulWidget {
  const ContactMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ContactMobile> createState() => _ContactMobileState();
}

class _ContactMobileState extends ConsumerState<ContactMobile> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final msgController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mqWidth = AppClass().getMqWidth(context);
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainTitleWidget(title: "What's Next?",isWeb: false,),
          Text(
            "Get In Touch",
            style: GoogleFonts.robotoSlab(
              color: AppColors().textColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 10,
              children: [
                CustomContactCard(
                  icon: Icons.call,
                  title: "Phone Number",
                  value: AppClass.phoneNumber,
                ),
                CustomContactCard(
                  icon: Icons.mail,
                  title: "Email Address",
                  value: AppClass.email,
                ),
              ],
            ),
          ),


          SizedBox(
            height: 30,
          ),

          Text(
            "Feel Free To Contact Me",
            style: GoogleFonts.robotoSlab(
              color: AppColors().textColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),

          SizedBox(height: 10,),

          Container(
            width: mqWidth * 0.9,
            child: Text(
              Strings.endTxt,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: AppColors().textLight,
                letterSpacing: 1,
                height: 1.5,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 20),

          Center(
            child: Container(
              width: mqWidth * 1,
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your name (or leave anonymous)';
                        }
                        return null;
                      },
                      decoration: _inputDecoration('Name*'),
                    ),
                    SizedBox(height: 20),

                    // Contact Info Field
                    TextFormField(
                      controller: emailController,
                      decoration: _inputDecoration('Email*'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Message Field
                    TextFormField(
                      controller: msgController,
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Message cannot be empty';
                        }
                        return null;
                      },
                      decoration: _inputDecoration('Message*'),
                    ),

                    SizedBox(height: 25),

                    Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 70),
                        child: CustomHoverButton(
                          height: 55,
                          width: 150,
                          text: "Send Message",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(progressProvider.notifier).state = true;
                              AppClass()
                                  .sendEmail(
                                nameController.text,
                                emailController.text,
                                msgController.text,
                              )
                                  .then((success) {
                                ref.read(progressProvider.notifier).state =
                                false;
                                if (success) {
                                  AppClass().successSnackBar(
                                      '🎉 Message sent successfully!',
                                      context: context);
                                  nameController.clear();
                                  emailController.clear();
                                  msgController.clear();
                                } else {
                                  AppClass().errorSnackBar(
                                      '😅 Something went wrong. Try again!',
                                      context: context);
                                }
                              });
                            }
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 50),

          // Footer
          Column(
            children: [
              Text(
                "Designed & Built with ❤️ by",
                style: GoogleFonts.inter(
                  color: AppColors().textLight.withOpacity(0.7),
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Shahzaib Hassan",
                style: GoogleFonts.poppins(
                  color: AppColors().primaryRedColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 1,
                    color: AppColors().primaryRedColor.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "© 2026 • All Rights Reserved",
                      style: GoogleFonts.inter(
                        color: AppColors().textLight.withOpacity(0.5),
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 1,
                    color: AppColors().primaryRedColor.withOpacity(0.3),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 50),

        ],
      ),
    );
  }
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500),
      errorStyle: TextStyle(color: AppColors().primaryRedColor),
      filled: true,
      fillColor: AppColors().cardColor.withOpacity(0.09),
      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors().cardColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors().cardColor, width: 2),
      ),
    );
  }
}
