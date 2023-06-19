import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/PROFILE/notificatios_screen.dart';
import 'package:yourfish/PROFILE/terms_privacy_screen.dart';
import 'package:yourfish/UTILS/app_strings.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'faq_screen.dart';
import 'help_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLocationOn = false;
  var selectedCategories = [];
  late List<String> listOfSettings = [
    "Notifications", "Invite Friends",
    "Terms & Conditions", "Privacy Policy",
    "FAQ'S", "Contact Us"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   titleSpacing: 0,
      //   title: const Text(
      //     "Settings",style: TextStyle(
      //       fontSize: 16,fontFamily: 'Rodetta',
      //       color: secondaryColor
      //   ),),
      //
      //   leading: IconButton(
      //     onPressed: () => Get.back(),
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //   ),
      // ),
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
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
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
                        border: Border.all(color: Colors.white, width: 0.67)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.redAccent,),
                        value: 0.67,
                      ),
                    ),
                  ),
                  const CustomText(
                    text: "67 km", color: Colors.white, weight: FontWeight.w600,)
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: listOfSettings.length,
                itemBuilder: (context, index) =>
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: ListTile(
                        onTap: () {
                          index == 0 ?
                          Get.to(const NotificationScreen(),
                              transition: Transition.rightToLeft)
                              : index == 1 ? shareApp()
                              : index == 2 ? Get.to(const PrivacyAndTermsScreen(
                            title: "Terms & Conditions",
                          ), transition: Transition.rightToLeft)
                              : index == 3 ?
                          Get.to(const PrivacyAndTermsScreen(
                            title: "Privacy Policy",
                          ), transition: Transition.rightToLeft)
                              : index == 4 ?
                          Get.to(const FAQScreen(),
                              transition: Transition.rightToLeft)
                              : Get.to( const HelpSupportScreen(),
                              transition: Transition.rightToLeft);
                        },
                        dense: true,
                        title: CustomText(
                          text: listOfSettings[index], color: primaryColor,
                          sizeOfFont: 16, weight: FontWeight.w700,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded, color: primaryColor,),


                      ),
                    ),),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(onPressed: () {
                      customDialog(
                          title: "Logout",
                          confirmBtnText: "Logout",
                          message: "Are you sure want to logout?"
                      );
                    },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1.5, color: secondaryColor),
                                borderRadius: BorderRadius.circular(4)
                            )
                        ),
                        child: const CustomText(
                          text: "Logout",
                          color: secondaryColor,
                          weight: FontWeight.w700,
                          sizeOfFont: 16,
                        )),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: TextButton(onPressed: () {
                      customDialog(
                        title: "Delete Account",
                        confirmBtnText: "Delete",
                        message: "Are you sure want to delete account?"
                      );
                    },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1.5, color: secondaryColor),
                                borderRadius: BorderRadius.circular(4)
                            )
                        ),
                        child: const CustomText(
                          text: "Delete Account",
                          color: secondaryColor,
                          weight: FontWeight.w700,
                          sizeOfFont: 16,
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

  shareApp  () {}
}





customDialog({String? title,String? message,String? confirmBtnText}) {
  Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                     Text(
                      "$title",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "$message",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    //Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                              backgroundColor: Colors.grey, minimumSize: const Size(0, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => Get.back(),
                            child: const Text(
                              'Cancel',style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                              backgroundColor: primaryColor, minimumSize: const Size(0, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: ()=> Get.back(),
                            child:  Text(
                              '$confirmBtnText',style: const TextStyle(color: Colors.white),
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