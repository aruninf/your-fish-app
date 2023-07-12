import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fish_you_experience.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_app_bar.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../UTILS/app_color.dart';
import '../UTILS/consts.dart';

class SelectFishInterest extends StatelessWidget {
  SelectFishInterest({super.key});
  final userController=Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    userController.getFish();
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: 'Select Fish you are\ninterested in catching',
              textColor: fishColor,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => Expanded(
                child: GridView.builder(
                  itemCount: userController.fishData.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 5 / 4),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.67, color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              userController.fishData[index].fishImage ?? '',
                              height: Get.width * 0.25,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            userController.fishData[index].fishName ?? '',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                )))
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
          onClick: () => Get.to(() => const SelectFishYouExperience(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
