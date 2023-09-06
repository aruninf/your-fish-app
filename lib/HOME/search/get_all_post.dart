import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_POST/add_fish_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';

class AllPostWidget extends StatelessWidget {
  AllPostWidget({super.key});
  final controller = Get.find<PostController>();
  final listOfBeach = [
    "Mermaid Beach",
    "Palm Beach",
    "Bondi Beach",
    "Manly Beach,",
    "Lizard Island"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: CustomSearchField(
            hintText: 'Search',
            onChanges: (p0) {

            },
          ),
        ),
        Expanded(
          child: Obx(() => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.postData.isEmpty
                  ? const Center(
                      child: Text(
                        "Not Post Yet!",
                        style: TextStyle(color: secondaryColor),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: controller.postData.length,
                      itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.network(
                                controller.postData[index].image ?? '',
                                height: Get.width * 0.32,
                                width: Get.width * 0.32,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  fishingImage,
                                  height: Get.width * 0.32,
                                  width: Get.width * 0.32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          )),
                    )),
        ),
      ],
    );
  }
}
