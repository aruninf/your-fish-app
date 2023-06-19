import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/create_account.dart';
import 'package:yourfish/CREATE_ACCOUNT/sign_in.dart';
import 'package:yourfish/CREATE_ACCOUNT/create_password.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

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
                    onClick: () => Get.to(() => const SignInScreen(),
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
                    onClick: () => Get.to(() => const CreateAccountScreen(),
                        transition: Transition.rightToLeft),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                const CustomText(
                  text: 'Login in with...',
                  color: secondaryColor,
                  sizeOfFont: 14,
                  weight: FontWeight.w700,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xffC4DAF0),
                      child: Image.asset(facebookImg,
                          color: primaryColor, height: 24, width: 24),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    CircleAvatar(
                      backgroundColor: const Color(0xffC4DAF0),
                      child: Image.asset(googleImg,
                          color: primaryColor, height: 24, width: 24),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    CircleAvatar(
                      backgroundColor: const Color(0xffC4DAF0),
                      child: Image.asset(
                        appleImg,
                        color: primaryColor,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Image.asset(
                  fishTextImage,
                  height: Get.width * 0.5,
                  width: Get.width * 0.5,
                  color: secondaryColor,
                ),
              ]),
        ),
      ),
    );
  }
}
