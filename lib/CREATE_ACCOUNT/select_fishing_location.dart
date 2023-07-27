import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fishing_category.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_app_bar.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class SelectFishingLocation extends StatelessWidget {
  SelectFishingLocation({super.key});
  final userController = Get.find<UserController>();

  void callApi() async {
    var data={
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
          () => userController.getFishLocation(data),
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
              heading: 'Locations where you \nGo fishing',
              textColor: fishColor,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search Location',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:  userController.isDataLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : userController.fishingLocation.isEmpty
                      ? const Center(
                    child: Text("No Record Found!",style: TextStyle(color: Colors.white),),
                  )
                      : ListView.builder(
                    itemCount: userController.fishingLocation.length,
                    itemBuilder: (context, index) => Obx(() => Container(
                      width: Get.width,
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: userController.selectedFishingLocation.contains(userController.fishingLocation[index].name)? fishColor : btnColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: (){
                          if(userController.selectedFishingLocation.contains(userController.fishingLocation[index].name)){
                            userController.selectedFishingLocation.remove(userController.fishingLocation[index].name);
                          }else{
                            userController.selectedFishingLocation.add(userController.fishingLocation[index].name);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: CustomText(
                            text: userController.fishingLocation[index].name ?? '',
                            sizeOfFont: 16,
                            weight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )),
                  ),
                ))
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
          onClick: (){
            if (userController.selectedFishingLocation.isEmpty) {
              Get.snackbar('Required!', 'Select at-least one',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var data={
              "location_id": userController.selectedFishingLocation.join(",").toString(),
            };
            userController.updateOnBoarding(data,3);
          },
        ),
      ),
    );
  }
}
