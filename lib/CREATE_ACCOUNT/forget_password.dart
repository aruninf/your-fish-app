import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../UTILS/app_color.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   centerTitle: true,
      //   title: Image.asset(fishTextImage,height: 60,width: 100,color: btnColor,),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(heading: 'Set Your Password', logoColor: btnColor),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      CommonTextField(
                        hintText: 'New Password',
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CommonTextField(
                        hintText: 'Confirm New Password',
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
          btnText: "Confirm",
          onClick: () => Get.to(() => const UploadProfilePicture(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
