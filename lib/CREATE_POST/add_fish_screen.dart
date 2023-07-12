import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class AddFishScreen extends StatelessWidget {
  AddFishScreen({super.key});

  final controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: 'Create Your Post',
              textColor: secondaryColor,
            ),
            Obx(() => Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
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
                                  text: controller.isLocationOn.value
                                      ? "Public Location"
                                      : "Private Location",
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Switch(
                                  activeColor: primaryColor,
                                  activeTrackColor: fishColor,
                                  value: controller.isLocationOn.value,
                                  onChanged: (value) {
                                    controller.isLocationOn.value =
                                        !controller.isLocationOn.value;
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
                              border:
                                  Border.all(width: 1, color: Colors.white)),
                          child: GestureDetector(
                            onTap: () {
                              DialogHelper.selectImageFrom(
                                  onClick: (uri) async {
                                    controller.uploadFile.value = uri!;
                                  },
                                  context: context);
                            },
                            child: controller.uploadFile.value.path.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      controller.uploadFile.value,
                                      fit: BoxFit.cover,
                                    ))
                                : const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                ))
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
