import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fishing_location.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/fish_selection_widget.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class SelectFishYouExperience extends StatelessWidget {
  SelectFishYouExperience({super.key});

  final userController = Get.find<UserController>();

  void callApi() async {
    var data={
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": 1,
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
          () => userController.getFish(data),
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
              heading: 'Select Fish you have\nExperience in catching',
              textColor: fishColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search',
                onChanges: (p0) {
                  var data={
                    "sortBy": "asc",
                    "sortOn": "created_at",
                    "page": 1,
                    "limit": "20",
                    "filter":p0
                  };
                  Future.delayed(
                    Duration.zero,
                        () => userController.getFish(data),
                  );
                },
                clear: callApi,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => Expanded(
                    child: userController.isDataLoading.value
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : userController.fishData.isEmpty
                        ? const Center(
                      child: Text("No Record Found!",style: TextStyle(color: Colors.white),),
                    )
                        :  GridView.builder(
                  itemCount: userController.fishData.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 5 / 4),
                  itemBuilder: (context, index) => FishItemSelectWidget(
                    fishData: userController.fishData[index],
                    selectedFishInterest: userController.selectedFishExp,
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
          onClick: () {
            if (userController.selectedFishExp.isEmpty) {
              Get.snackbar('Required!', 'Select at least one',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var data={
              "experience_fish_id":  userController.selectedFishExp.join(",").toString(),
            };
            userController.updateOnBoarding(data,2);

          },
        ),
      ),
    );
  }
}
