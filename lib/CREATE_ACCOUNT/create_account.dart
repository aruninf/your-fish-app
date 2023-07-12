import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
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
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
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
                    Padding(
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
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CommonTextField(
                            hintText: 'Email',
                            controller: userController.emailController,
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
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: TextFormField(
                                          onTap: () => userController
                                              .selectDate(context),
                                          controller: userController.dobController,
                                          readOnly: true,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16),
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'required';
                                            }
                                            return null;
                                          },
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
                                      callback: (val) => userController.gender = val),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(
                            height: 12,
                          ),
                          CommonTextField(
                            hintText: 'Phone Number',
                            controller: userController.numberController,
                            textInputType: TextInputType.number,
                            maxLength: 10,
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
            if (_formKey.currentState!.validate()) {
              if((userController.gender??'').isEmpty){
                DialogHelper.showErrorDialog(title: "",description: 'Select Gender');
                return;
              }
              if((userController.dobController.text??'').isEmpty){
                DialogHelper.showErrorDialog(description: "Select DOB",title: '');

                return;
              }
              dynamic data={
                "social_type": socialType,
                "social_id": socialId,
                'name':userController.nameController.text.trim(),
                'handle':userController.handleController.text.trim(),
                'email':userController.emailController.text.trim(),
                'dob':userController.dobController.text.trim(),
                'gender':userController.gender,
                'number':userController.numberController.text.trim()
              };
              Get.to(() => CreatePasswordScreen(data: data),
                  transition: Transition.rightToLeft);
            }
          },
        ),
      ),
    );
  }
}
