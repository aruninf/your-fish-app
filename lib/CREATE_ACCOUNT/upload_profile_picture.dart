import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fish_interest.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class UploadProfilePicture extends StatelessWidget {
  const UploadProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(
                    heading: 'Add Profile Photo', logoColor: btnColor),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: Get.height * 0.32,
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 40,
                        color: secondaryColor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Upload Photo',
                        color: btnColor,
                        weight: FontWeight.w700,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: Get.height * 0.09,
              left: 0,
              child: Image.asset(
                fishUpdateImg,
                height: Get.width * 0.35,
                width: Get.width * 0.5,
                fit: BoxFit.fill,
                color: Colors.white70,
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
          btnText: "NEXT",
          onClick: () => Get.to(() => const SelectFishInterest(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
