import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/consts.dart';

class MyGearWidget extends StatelessWidget {
  MyGearWidget({super.key});

  final controller = Get.find<UserController>();

  void getMyGear() {
    var data = {
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
      () => controller.getFishGear(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    getMyGear();
    return Obx(
      () => controller.isDataLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.fishingGear.isEmpty
              ? const Center(
                  child: Text(
                    "No Record Found!",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.fishingGear.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Obx(() => Container(
                        width: Get.width,
                        margin:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            // if (controller
                            //     .selectedFishingLocation
                            //     .contains(controller
                            //     .fishingLocation[index].name)) {
                            //   controller.selectedFishingLocation
                            //       .remove(controller
                            //       .fishingLocation[index].name);
                            // } else {
                            //   controller.selectedFishingLocation
                            //       .add(controller
                            //       .fishingLocation[index].name);
                            // }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:16,vertical: 10 ),
                            child: CustomText(
                              text: controller.fishingGear[index].title ?? '',
                              sizeOfFont: 16,
                              weight: FontWeight.w800,
                            ),
                          ),
                        ),
                      )),
                ),
    );
  }
}
