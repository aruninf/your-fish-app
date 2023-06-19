import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fish_interest.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'get_start.dart';

class UploadProfilePicture extends StatelessWidget {
  const UploadProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Image.asset(fishTextImage,height: 60,width: 100,color: btnColor,),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height*0.03,
                  ),
                  const Text( 'Add Profile Photo',
                    style: TextStyle(
                        color: secondaryColor,
                        fontFamily: "Rodetta",
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                    ),),

                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: Get.height*0.35,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1,color: Colors.white)
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline_rounded,size: 40,color: secondaryColor,),
                        SizedBox(height: 8,),
                        CustomText(text: 'Upload Photo',color: Colors.white,weight: FontWeight.w700,)
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              bottom: Get.height*0.15,
              left: 0,
              child: Image.asset(
                fishSignImage,
                height: Get.width * 0.35,
                width: Get.width * 0.5,
                fit: BoxFit.fill,
                color: Colors.white30,
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
          onClick: () => Get.to(()=>const SelectFishInterest(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
