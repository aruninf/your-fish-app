import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/auth_controller.dart';
import 'package:yourfish/CONTROLLERS/setting_controller.dart';
import 'package:yourfish/HOME/profile/get_saved_post.dart';
import 'package:yourfish/PROFILE/notificatios_screen.dart';
import 'package:yourfish/PROFILE/terms_privacy_screen.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'faq_screen.dart';
import 'help_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final controller = Get.put(SettingController());

  void callFaqApi() async {
    var data = {
      "sortBy": "desc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
      () => controller.getFaq(data),
    );
  }

  void callPrivacyPolicyApi() async {
    Future.delayed(
      Duration.zero,
      () => controller.getContent(),
    );
  }

  callBlogArticleApi() async {
    var data = {
      "sortBy": "desc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
      () => controller.getBlogs(data),
    );
    Future.delayed(
      Duration.zero,
      () => controller.getArticles(data),
    );
  }

  void getSetting() {
    Future.delayed(
      Duration.zero,
      () => controller.getSettingData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    getSetting();
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
            SliderTheme(
              data: const SliderThemeData(
                trackHeight: 26,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 16.0,
                ),
                trackShape: RoundedRectSliderTrackShape(),
              ),
              child: Obx(() => Stack(
                    alignment: Alignment.center,
                    children: [
                      Slider(
                        max: 100,
                        divisions: 50,
                        activeColor: Colors.redAccent,
                        inactiveColor: btnColor,
                        value: controller.currentValues.value,
                        label: '${controller.currentValues.value.toInt()}',
                        onChanged: (double value) {
                          controller.currentValues.value = value;
                        },
                        onChangeEnd: (value) {
                          var data = {
                            "public_feed": controller.currentValues.value
                          };
                          controller.updatePublicFeedRadios(data);
                        },
                      ),
                      CustomText(
                        text: "${controller.currentValues.value.toInt()} km",
                        color: primaryColor,
                        weight: FontWeight.w800,
                        sizeOfFont: 15,
                      )
                    ],
                  )),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       Container(
            //         height: 30,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(16),
            //             border: Border.all(color: Colors.white, width: 0.67)),
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(16),
            //           child: const LinearProgressIndicator(
            //             backgroundColor: Colors.transparent,
            //             valueColor: AlwaysStoppedAnimation<Color>(
            //               Colors.redAccent,
            //             ),
            //             value: 0.40,
            //           ),
            //         ),
            //       ),
            //       const CustomText(
            //         text: "25 km",
            //         color: btnColor,
            //         weight: FontWeight.w800,
            //         sizeOfFont: 15,
            //       )
            //     ],
            //   ),
            // ),
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
                      if (index == 0) {
                        Get.to(SavedPostWidget(),
                            transition: Transition.rightToLeft);
                      } else if (index == 1) {
                        Get.to(NotificationScreen(),
                            transition: Transition.rightToLeft);
                      } else if (index == 2) {
                        controller.shareApp();
                      } else if (index == 3) {
                        callPrivacyPolicyApi();
                        Get.to(
                            PrivacyAndTermsScreen(
                              title: "Terms & Conditions",
                            ),
                            transition: Transition.rightToLeft);
                      } else if (index == 4) {
                        callPrivacyPolicyApi();
                        Get.to(
                            PrivacyAndTermsScreen(
                              title: "Privacy Policy",
                            ),
                            transition: Transition.rightToLeft);
                      } else if (index == 5) {
                        callFaqApi();
                        Get.to(FAQScreen(), transition: Transition.rightToLeft);
                      } else {
                        Get.to(HelpSupportScreen(),
                            transition: Transition.rightToLeft);
                      }
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
}

void customDialog({String? title, String? message, String? confirmBtnText}) {
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
                              backgroundColor: Colors.white,
                              minimumSize: const Size(0, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => Get.back(),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: primaryColor),
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
                            onPressed: () =>
                                Get.find<AuthController>().logoutUser(),
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
