import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({super.key,required this.data});
  final dynamic data;
  final _formKey=GlobalKey<FormState>();

  final password=TextEditingController();
  final confirmPassword=TextEditingController();
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
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(heading: 'Set Your Password', logoColor: btnColor),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextField(
                          hintText: 'Password',
                          controller: password,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CommonTextField(
                          hintText: 'Confirm Password',
                          controller: confirmPassword,
                          isPassword: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
            if(_formKey.currentState!.validate()){
              if((password.text??'')!=confirmPassword.text){
                DialogHelper.showErrorDialog(description: "Confirm password not same",title: '');
                return;
              }
              var  newData={
                'password':confirmPassword.text.trim(),
                ...data
              };
              Get.to(() =>  UploadProfilePicture(data: newData,),
                  transition: Transition.rightToLeft);
            }

          },
        ),
      ),
    );
  }
}
