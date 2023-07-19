import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CONTROLLERS/auth_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../UTILS/app_color.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final email=TextEditingController();
  final userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(heading: 'Forgot Your Password', logoColor: btnColor),
                const SizedBox(height: 16,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Enter Your Registered email address\nwe will send you a password reset link on \nthis email address.",
                  style: TextStyle(color: secondaryColor,),),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      CommonTextField(
                        controller: email,
                        hintText: 'Email',
                      ),

                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: Get.height * 0.10,
              left: 0,
              child: Image.asset(
                fishUpdateImg,
                height: Get.width * 0.35,
                width: Get.width * 0.5,
                fit: BoxFit.fill,
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "Send reset link",
          onClick: () {
            if (email.text == '' ||
                email.text.isEmpty ||
                !email.text.contains('@') ||
                !email.text.contains('.')) {
              Get.snackbar('Required!', 'Enter Valid Email',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            userController.forgotPassword(email.text.trim());

          },
        ),
      ),
    );
  }
}
