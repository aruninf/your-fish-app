import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/create_account.dart';
import 'package:yourfish/CREATE_ACCOUNT/sign_in.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:yourfish/PROFILE/terms_privacy_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CONTROLLERS/auth_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';

class GetStartScreen extends StatelessWidget {
  GetStartScreen({super.key});

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                ),
                Image.asset(
                  fishImage,
                  height: Get.width * 0.35,
                  width: Get.width * 0.5,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  width: Get.width,
                  height: 55,
                  child: CommonButton(
                    btnBgColor: const Color(0xffC4DAF0),
                    btnTextColor: primaryColor,
                    btnText: "Log In",
                    onClick: () => Get.to(() => SignInScreen(),
                        transition: Transition.rightToLeft),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  width: Get.width,
                  height: 55,
                  child: CommonButton(
                    btnBgColor: const Color(0xffC4DAF0),
                    btnTextColor: primaryColor,
                    btnText: "Sign Up",
                    onClick: () => Get.to(
                        () => CreateAccountScreen(
                              socialId: '',
                              socialType: 'email',
                            ),
                        transition: Transition.rightToLeft),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width * 0.2,
                      height: 0.7,
                      color: btnColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomText(
                        text: 'Or Continue with',
                        color: secondaryColor,
                        sizeOfFont: 14,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.2,
                      height: 0.7,
                      color: btnColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async => await controller.signInWithFaceBook(),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xffC4DAF0),
                        child: Image.asset(facebookImg,
                            color: primaryColor, height: 24, width: 24),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async => await controller.signInWithGoogle(),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xffC4DAF0),
                        child: Image.asset(googleImg,
                            color: primaryColor, height: 24, width: 24),
                      ),
                    ),
                    SizedBox(
                      width: Platform.isIOS ? Get.width * 0.02 : 0,
                    ),
                    Platform.isIOS
                        ? GestureDetector(
                            onTap: () async =>
                                await controller.signInWithApple(),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xffC4DAF0),
                              child: Image.asset(
                                appleImg,
                                color: primaryColor,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () =>
                      Get.to(PrivacyAndTermsScreen(title: "Privacy Policy")),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "By Continue you agree to the our",
                            style: TextStyle(color: btnColor)),
                        TextSpan(
                            text: " Privacy Policy",
                            style: TextStyle(
                                color: fishColor, fontWeight: FontWeight.w600)),
                      ])),
                ),
                InkWell(
                  onTap: () => Get.to(PrivacyAndTermsScreen(
                    title: "Terms & Conditions",
                  )),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: [
                        TextSpan(
                            text: " and ", style: TextStyle(color: btnColor)),
                        TextSpan(
                            text: "Terms and Conditions.",
                            style: TextStyle(
                                color: fishColor, fontWeight: FontWeight.w600))
                      ])),
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  fishTextImage,
                  height: Get.width * 0.3,
                  width: Get.width * 0.4,
                  color: secondaryColor,
                ),
              ]),
        ),
      ),
    );
  }
}
