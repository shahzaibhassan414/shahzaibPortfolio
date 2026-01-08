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

class ContactTab extends ConsumerStatefulWidget {
  const ContactTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends ConsumerState<ContactTab> {

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
            width: mqWidth * 0.7,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Built & Developed by ",
                style: TextStyle(
                    color: AppColors().textColor,
                    fontSize: 13,
                    fontFamily: 'sfmono'),
              ),
              Text(
                "Shahzaib 🫡",
                style: TextStyle(
                    color: AppColors().primaryRedColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sfmono'),
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
