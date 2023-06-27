import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class AddFishScreen extends StatefulWidget {
  const AddFishScreen({super.key});

  @override
  State<AddFishScreen> createState() => _AddFishScreenState();
}

class _AddFishScreenState extends State<AddFishScreen> {
  bool isLocationOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   titleSpacing: 0,
      //   title: const Text(
      //     'Create Your Post',style: TextStyle(
      //       fontSize: 16,fontFamily: 'Rodetta',
      //       color: secondaryColor
      //   ),
      //   ),
      //   leading: IconButton(
      //     onPressed: ()=> Get.back(),
      //     icon: const Icon(Icons.arrow_back_ios_new_rounded,color: fishColor,),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: 'Create Your Post',
              textColor: secondaryColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        child: Row(
                          children: [
                            const Icon(
                              PhosphorIcons.map_pin,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            CustomText(
                              text: isLocationOn
                                  ? "Public Location"
                                  : "Private Location",
                              color: Colors.white,
                            ),
                            const Spacer(),
                            Switch(
                              activeColor: primaryColor,
                              activeTrackColor: fishColor,
                              value: isLocationOn,
                              onChanged: (value) {
                                setState(() {
                                  isLocationOn = !isLocationOn;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
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
                        hintText: "Tag Fish",
                        hintStyle: const TextStyle(color: Colors.white54),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: Get.height * 0.33,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: Colors.white)),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline_rounded,
                            size: 48,
                            color: secondaryColor,
                            weight: 800,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomText(
                            text: 'Upload Post',
                            color: btnColor,
                            weight: FontWeight.w800,
                            sizeOfFont: 16,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
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
                        hintText: "Caption...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    )
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
          btnText: "Post",
          onClick: () => Get.back(),
        ),
      ),
    );
  }
}
