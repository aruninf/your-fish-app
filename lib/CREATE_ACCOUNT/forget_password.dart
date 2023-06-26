import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/create_account.dart';
import 'package:yourfish/CREATE_ACCOUNT/sign_in.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'get_start.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
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
      body: Stack  (
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height*0.03,
                ),
                const Text( 'Set Your Password',
                  style: TextStyle(
                      color: secondaryColor,
                      fontFamily: "Rodetta",
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                  ),),

                const SizedBox(
                  height: 16,
                ),
                const CommonTextField(
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 25,
                ),
                const CommonTextField(
                  hintText: 'Confirm Password',
                ),


              ],
            ),
          ),
          Positioned(
            bottom: Get.height*0.10,
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
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () => Get.to(()=>const UploadProfilePicture(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
