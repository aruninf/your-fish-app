import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/gender_dropdown.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';
import 'create_password.dart';


class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen(
      {super.key, required this.socialId, required this.socialType});

  final String socialId;
  final String socialType;

  final userController = Get.put(UserController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //extendBody: true,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(
                      heading: 'Create\nYour Account', logoColor: btnColor),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          hintText: 'Name',
                          controller: userController.nameController,
                          maxLength: 16,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CommonTextField(
                          hintText: 'Handle',
                          controller: userController.handleController,
                          maxLength: 20,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CommonTextField(
                          hintText: 'Email',
                          isReadOnly:(socialType=='google' && socialId.isNotEmpty) ? true : false,
                          controller: userController.emailController,
                          maxLength: 30,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Obx(() {
                          userController.dobController.text = userController.selectDob.value;
                          return Wrap(
                            direction: Axis.horizontal,
                            children: [
                              SizedBox(
                                width: Get.width * 0.44,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: btnColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: TextFormField(
                                        onTap: () =>
                                            userController.selectDate(context),
                                        controller:
                                            userController.dobController,
                                        readOnly: true,
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 16),
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800),
                                            hintText: 'Select DOB'))),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              SizedBox(
                                width: Get.width * 0.44,
                                child: GenderDropdown(
                                    dropdownValue: userController.gender,
                                    callback: (val) =>
                                        userController.gender = val),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: btnColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: TextFormField(
                              controller: userController.numberController,
                              keyboardType: TextInputType.number,
                              //obscureText:(isPassword ?? false) ? uController.isPasswordVisible.value : false,
                              maxLines: 1,
                              maxLength: 10,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                  hintText: 'Phone Number')),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
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
            if ((userController.nameController.text ?? '').length<3) {
              Get.snackbar('Required!', 'Enter valid name',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            if ((userController.handleController.text ?? '').length<3) {
              Get.snackbar('Required!', 'Please enter the correct handle',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);

              return;
            }
            if (userController.emailController.text == '' ||
                userController.emailController.text.isEmpty ||
                !userController.emailController.text.contains('@') ||
                !userController.emailController.text.contains('.')) {
              Get.snackbar('Required!', 'Please enter the correct email',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);

              return;
            }

            if ((userController.dobController.text ?? '').isEmpty) {
              Get.snackbar('Required!', 'Select DOB',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }

            if ((userController.numberController.text ?? '').length < 10) {
              Get.snackbar('Required!', 'Please enter the correct phone number',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);

              return;
            }
            dynamic data = {
              "user_type": "user",
              "social_type": socialType,
              "social_id": socialId,
              'name': userController.nameController.text.trim(),
              'handle': userController.handleController.text.trim(),
              'email': userController.emailController.text.trim(),
              'dob': userController.dobController.text.trim(),
              'gender': userController.gender ?? 'Male',
              'phone_number': userController.numberController.text.trim()
            };
            if(socialType=='google' && socialId.isNotEmpty){
              var newData = {'password': "12345678", ...data};
              Get.to(
                      () => UploadProfilePicture(
                    data: newData,
                  ),
                  transition: Transition.rightToLeft);
            }else{
              Get.to(() => CreatePasswordScreen(data: data),
                  transition: Transition.rightToLeft);
            }

          },
        ),
      ),
    );
  }
}
