import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/auth_controller.dart';
import 'package:yourfish/CONTROLLERS/setting_controller.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/PROFILE/notificatios_screen.dart';
import 'package:yourfish/PROFILE/terms_privacy_screen.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'faq_screen.dart';
import 'help_screen.dart';



class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final controller=Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: "Settings",
              textColor: secondaryColor,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CustomText(
                text: 'Public Feed Content',
                color: btnColor,
                sizeOfFont: 16,
                weight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 0.67)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.redAccent,
                        ),
                        value: 0.40,
                      ),
                    ),
                  ),
                  const CustomText(
                    text: "25 km",
                    color: btnColor,
                    weight: FontWeight.w800,
                    sizeOfFont: 15,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.listOfSettings.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      color: btnColor, borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    onTap: () {
                      index == 0
                          ? Get.to(const NotificationScreen(),
                          transition: Transition.rightToLeft)
                          : index == 1
                          ? shareApp()
                          : index == 2
                          ? Get.to(
                          const PrivacyAndTermsScreen(
                            title: "Terms & Conditions",
                          ),
                          transition: Transition.rightToLeft)
                          : index == 3
                          ? Get.to(
                          const PrivacyAndTermsScreen(
                            title: "Privacy Policy",
                          ),
                          transition: Transition.rightToLeft)
                          : index == 4
                          ? Get.to( FAQScreen(),
                          transition:
                          Transition.rightToLeft)
                          : Get.to(const HelpSupportScreen(),
                          transition:
                          Transition.rightToLeft);
                    },
                    dense: true,
                    title: CustomText(
                      text: controller.listOfSettings[index],
                      color: primaryColor,
                      sizeOfFont: 16,
                      weight: FontWeight.w700,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          customDialog(
                              title: "Logout",
                              confirmBtnText: "Logout",
                              message: "Are you sure want to logout?");
                        },
                        style: TextButton.styleFrom(
                          // shape: RoundedRectangleBorder(
                          //     side: const BorderSide(
                          //         width: 1.5, color: secondaryColor),
                          //     borderRadius: BorderRadius.circular(4)
                          // )
                            alignment: Alignment.centerLeft),
                        child: const CustomText(
                          text: "Log out",
                          color: secondaryColor,
                          weight: FontWeight.w700,
                          sizeOfFont: 18,
                        )),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          customDialog(
                              title: "Delete Account",
                              confirmBtnText: "Delete",
                              message: "Are you sure want to delete account?");
                        },
                        style: TextButton.styleFrom(
                          // shape: RoundedRectangleBorder(
                          //     side: const BorderSide(
                          //         width: 1.5, color: secondaryColor),
                          //     borderRadius: BorderRadius.circular(4)
                          // )
                            alignment: Alignment.centerRight),
                        child: const CustomText(
                          text: "Delete Account",
                          color: secondaryColor,
                          weight: FontWeight.w600,
                          sizeOfFont: 13,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  shareApp() {}
}

customDialog({String? title, String? message, String? confirmBtnText}) {
  Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                color: primaryColor,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "$title",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "$message",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    //Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                              backgroundColor: Colors.grey,
                              minimumSize: const Size(0, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => Get.back(),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: fishColor,
                              backgroundColor: fishColor,
                              minimumSize: const Size(0, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () =>Get.find<AuthController>().logoutUser(),
                            child: Text(
                              '$confirmBtnText',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
