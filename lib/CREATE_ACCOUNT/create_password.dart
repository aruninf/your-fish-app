import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/auth_controller.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../UTILS/app_color.dart';

class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({super.key, required this.data});

  final dynamic data;
  final _formKey = GlobalKey<FormState>();

  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Obx(() {
                print(controller.isPasswordVisible.value);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(
                        heading: 'Set Your Password', logoColor: btnColor),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: btnColor,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: TextFormField(
                                controller: password,
                                keyboardType: TextInputType.text,
                                obscureText: controller.isPasswordVisible.value,
                                maxLines: 1,
                                maxLength: 16,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: '',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                    hintText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.isPasswordVisible.value =
                                            !controller.isPasswordVisible.value;
                                      },
                                      child: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ))),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: btnColor,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: TextFormField(
                                controller: confirmPassword,
                                keyboardType: TextInputType.text,
                                obscureText:
                                    controller.isPasswordVisible1.value,
                                maxLines: 1,
                                maxLength: 16,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: '',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                    hintText: 'Confirm Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.isPasswordVisible1.value =
                                            !controller
                                                .isPasswordVisible1.value;
                                      },
                                      child: Icon(
                                        controller.isPasswordVisible1.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ))),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
            Positioned(
              bottom: Get.height * 0.10,
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
            if (password.text.length < 6 || password.text.isEmpty) {
              Get.snackbar(
                  'Required!', 'Password must be at least 6 characters long',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            if (!password.text.contains(RegExp(r"[a-z]"))) {
              Get.snackbar('Required!',
                  'Password must have at least one lowerCase letter',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            if (!password.text.contains(RegExp(r"[A-Z]"))) {
              Get.snackbar('Required!',
                  'Password must have at least one upperCase letter',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            if (!password.text.contains(RegExp(r"[0-9]"))) {
              Get.snackbar(
                  'Required!', 'Password must have at least one number',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            if (!password.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
              Get.snackbar('Required!',
                  'Password must be at least one special character',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }

            if ((password.text ?? '') != confirmPassword.text) {
              Get.snackbar('Required!', 'Confirm password not same',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var newData = {'password': confirmPassword.text.trim(), ...data};
            Get.to(
                () => UploadProfilePicture(
                      data: newData,
                    ),
                transition: Transition.rightToLeft);
          },
        ),
      ),
    );
  }
}
