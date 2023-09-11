import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_app_bar.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../CUSTOM_WIDGETS/fish_selection_widget.dart';
import '../UTILS/app_color.dart';

class SelectFishInterest extends StatelessWidget {
  SelectFishInterest({super.key});

  final userController = Get.find<UserController>();

  void callApi() async {
    var data={
      "sortBy": "asc",
      "sortOn": "id",
      "page": 1,
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
      () => userController.getFish(data),
    );
    Future.delayed(
      Duration.zero,
          () => userController.getFishCategory(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    callApi();
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Obx(() => Column(
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

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(userController.fishCategory.length, (index) => Container(
                  margin: const EdgeInsets.only(top: 0, left: 16,right: 8,bottom: 6),
                  decoration: BoxDecoration(
                    color: userController.fishCategory[index].id ==userController.selectedCategory.value
                        ? secondaryColor
                        : btnColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                       userController.selectedCategory.value=userController.fishCategory[index].id ?? 0;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: CustomText(
                        text: userController.fishCategory[index].name ?? '',
                        sizeOfFont: 16,
                        weight: FontWeight.bold,
                        color: userController.fishCategory[index].id ==userController.selectedCategory.value
                            ? fishColor
                            : primaryColor,
                      ),
                    ),
                  ),
                )),
              ),
            ),

            Expanded(
                child: userController.isDataLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : userController.fishData.isEmpty
                    ? const Center(
                  child: Text(
                    "No Record Found!",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : GridView.builder(
                  itemCount: userController.fishData.length,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 5 / 4),
                  itemBuilder: (context, index) =>
                      FishItemSelectWidget(
                          fishData: userController.fishData[index],
                          selectedFishInterest:
                          userController.selectedFishInterest),
                ))
          ],
        )),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () async {
            if (userController.selectedFishInterest.isEmpty) {
              Get.snackbar('Required!', 'Select at-least one',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var data = {
              "interested_fish_id":
                  userController.selectedFishInterest.join(",").toString(),
            };
            userController.updateOnBoarding(data, 1);
          },
        ),
      ),
    );
  }
}
