import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../HOME/main_home.dart';
import '../UTILS/app_color.dart';
import 'forget_password.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: fishColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Image.asset(
                    fishTextImage,
                    height: Get.width * 0.45,
                    width: Get.width * 0.6,
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  const CommonTextField(
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const CommonTextField(
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 55,
                    child: CommonButton(
                      btnBgColor: fishColor,
                      btnTextColor: primaryColor,
                      btnText: "Log In",
                      onClick: () => Get.to(() => const MainHome(),
                          transition: Transition.rightToLeft),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => (
                        Get.to(() => const ForgotPasswordScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      child: const SizedBox(
                        child: CustomText(
                          text: 'Forgot Password?',
                          color: secondaryColor,
                          sizeOfFont: 16,
                          weight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                fishSignImage,
                height: Get.width * 0.45,
                width: Get.width * 0.7,
                fit: BoxFit.fill,
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
