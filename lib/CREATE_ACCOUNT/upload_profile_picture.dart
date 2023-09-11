import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/NETWORKS/network.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class UploadProfilePicture extends StatelessWidget {
  UploadProfilePicture({super.key, required this.data});

  final dynamic data;
  final imageUrl = ''.obs;
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: primaryColor,
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
                Obx(
                  () => Container(
                    height: Get.height * 0.32,
                    width: Get.width,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: GestureDetector(
                      onTap: () {
                        DialogHelper.selectImageFrom(
                            onClick: (uri) async {
                              imageUrl.value =
                                  await Network().uploadFile(uri!, 'profile') ?? '';
                              //Get.find<UserController>().uploadFile.value = uri;
                              //Get.back();
                            },
                            context: context);
                      },
                      child: (imageUrl.value
                              .isNotEmpty)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                imageUrl.value,
                                fit: BoxFit.cover,
                              ))
                          : const Column(
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
                  ),
                )
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
          onClick: () {
            if (imageUrl.value.isEmpty) {
              Get.snackbar('Required!', 'Select Profile Picture',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var finalData = {'profile_pic': imageUrl.value, ...data};
            userController.userRegister(finalData);

          },
        ),
      ),
    );
  }
}
