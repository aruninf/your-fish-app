import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Image.asset(
        appLogo,
        height: Get.width * 0.85,
        width: Get.width * 0.85,
      )),
    );
  }
}
