import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/HOME/location_page.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../NETWORKS/network.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class AddFishScreen extends StatelessWidget {
  AddFishScreen({super.key});

  final controller = Get.put(PostController());
  final imageUrl = ''.obs;
  final _formKey = GlobalKey<FormState>();
  final tagFishController = TextEditingController();
  final captionsController = TextEditingController();

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
                    child: Form(
                      key: _formKey,
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
                                      if(controller.isLocationOn.value){
                                        Get.to(LocationPage());
                                      }
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
                            controller: tagFishController,
                            style: const TextStyle(color: Colors.white),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Tags required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                const BorderSide(color: Colors.white,width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
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
                                      imageUrl.value = await Network()
                                              .uploadFile(uri!, 'fish') ??
                                          '';
                                      controller.uploadFile.value = uri;
                                      //Get.back();
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            controller: captionsController,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 3,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Caption required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    const BorderSide(color: Colors.white,width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                const BorderSide(color: Colors.white,width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    const BorderSide(color: Colors.white,width: 1),
                              ),
                              hintText: "Caption...",
                              hintStyle: const TextStyle(color: Colors.white54),
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
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
          onClick: () {
            if (_formKey.currentState!.validate()) {
              var data = {
                "location_id": controller.isLocationOn.value ? 2 : 0,
                "tag_fish": tagFishController.text.trim(),
                "image": imageUrl.value,
                "caption": captionsController.text.trim()
              };
              controller.createPost(data);
            }
          },
        ),
      ),
    );
  }
}
