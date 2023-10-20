import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/auth_controller.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';

import '../CONTROLLERS/setting_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../UTILS/app_color.dart';



class HelpSupportScreen extends StatelessWidget {
  HelpSupportScreen({super.key});

  final controller = Get.find<SettingController>();
  final userController = Get.find<PostController>();

  final nameCo=TextEditingController();
  final email=TextEditingController();
  final commentCo=TextEditingController();

  @override
  Widget build(BuildContext context) {
    email.text=userController.userData.value.email ?? '';
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: "Help",
              textColor: secondaryColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameCo,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "Subject",
                        hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: email,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "Email",
                        hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: commentCo,
                      textInputAction: TextInputAction.done,

                      style: const TextStyle(color: Colors.white),
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "Message...",
                        hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: secondaryColor,
          btnTextColor: primaryColor,
          btnText: "Submit",
          onClick: () => submitRequest(),
        ),
      ),
    );
  }

  submitRequest() {

    if (nameCo.text.length < 3) {
      Get.snackbar('Required!', 'Please enter the correct subject',
          colorText: Colors.orange,
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (email.text.length < 3) {
      Get.snackbar('Required!', 'Please enter the correct email',
          colorText: Colors.orange,
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (commentCo.text.length < 3) {
      Get.snackbar('Required!', 'Please enter the correct message',
          colorText: Colors.orange,
          snackPosition: SnackPosition.TOP);
      return;
    }


    var data={
      "name": nameCo.text.trim(),
      "email": email.text.trim(),
      "comments": commentCo.text.trim()
    };
    controller.sendMessageToAdmin(data);
  }
}
