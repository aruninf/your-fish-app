import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'create_password.dart';
import 'get_start.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack  (
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(heading: 'Create Your Account',
                  logoColor: btnColor),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const CommonTextField(
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const CommonTextField(
                          hintText: 'Handle',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const CommonTextField(
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            SizedBox(
                              width: Get.width*0.44,
                              child: const CommonTextField(
                                hintText: 'DOB',
                              ),
                            ),
                            SizedBox(
                              width: Get.width*0.03,
                            ),
                            SizedBox(
                              width: Get.width*0.44,
                              child: const CommonTextField(
                                hintText: 'Gender',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        const CommonTextField(
                          hintText: 'Phone Number',
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
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
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () => Get.to(()=>const CreatePasswordScreen(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
