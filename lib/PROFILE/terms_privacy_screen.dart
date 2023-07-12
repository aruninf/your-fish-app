import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_strings.dart';

class PrivacyAndTermsScreen extends StatelessWidget {
  const PrivacyAndTermsScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              heading: title,
              textColor: secondaryColor,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.78, color: Colors.white),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: const Text(
                        privacyText,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.4,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
