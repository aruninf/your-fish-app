import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'add_your_gear.dart';

class SelectFishingCategory extends StatelessWidget {
  SelectFishingCategory({super.key});

  final controller =Get.put(UserController());
  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  children: List.generate(
                      controller.listOfCategory.length,
                      (index) => Container(
                            margin: const EdgeInsets.only(top: 12, left: 16),
                            decoration: BoxDecoration(
                              color: controller.selectedCategories
                                      .contains(controller.listOfCategory[index])
                                  ? secondaryColor
                                  : btnColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (controller.selectedCategories
                                    .contains(controller.listOfCategory[index])) {
                                  controller.selectedCategories
                                      .remove(controller.listOfCategory[index]);
                                } else {
                                  controller.selectedCategories
                                      .add(controller.listOfCategory[index]);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                child: CustomText(
                                  text: controller.listOfCategory[index],
                                  sizeOfFont: 16,
                                  weight: FontWeight.bold,
                                  color: controller.selectedCategories
                                          .contains(controller.listOfCategory[index])
                                      ? fishColor
                                      : primaryColor,
                                ),
                              ),
                            ),
                          )),
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
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () => Get.to(() => const AddYourGear(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
