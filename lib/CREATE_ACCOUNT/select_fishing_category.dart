import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';
import 'add_your_gear.dart';

class SelectFishingCategory extends StatelessWidget {
  SelectFishingCategory({super.key});

  final controller =Get.put(UserController());


  void callApi() async {
    var data={
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
          () => controller.getFishCategory(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    callApi();
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: 'Select you favourite \nFishing categories',
              textColor: fishColor,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search Category',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: controller.isDataLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : controller.fishCategory.isEmpty
                    ? const Center(
                  child: Text("No Record Found!",style: TextStyle(color: Colors.white),),
                )
                    :  Wrap(
                  children: List.generate(
                      controller.fishCategory.length,
                          (index) => Obx(() => Container(
                            margin: const EdgeInsets.only(top: 12, left: 16),
                            decoration: BoxDecoration(
                              color: controller.selectedCategories
                                  .contains(controller.fishCategory[index].id)
                                  ? secondaryColor
                                  : btnColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                if (controller.selectedCategories
                                    .contains(controller.fishCategory[index].id)) {
                                  controller.selectedCategories
                                      .remove(controller.fishCategory[index].id);
                                } else {
                                  controller.selectedCategories
                                      .add(controller.fishCategory[index].id);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                child: CustomText(
                                  text: controller.fishCategory[index].name ?? '',
                                  sizeOfFont: 16,
                                  weight: FontWeight.bold,
                                  color: controller.selectedCategories
                                      .contains(controller.fishCategory[index].id)
                                      ? fishColor
                                      : primaryColor,
                                ),
                              ),
                            ),
                          )
                          )
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
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () {
            if (controller.selectedCategories.isEmpty) {
              Get.snackbar('Required!', 'Select at-least one',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var data={
              "fish_cat_id": controller.selectedCategories.join(",").toString(),
            };
            controller.updateOnBoarding(data,4);
          },
        ),
      ),
    );
  }
}
