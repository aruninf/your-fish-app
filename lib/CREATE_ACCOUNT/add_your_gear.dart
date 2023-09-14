import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class AddYourGear extends StatelessWidget {
  AddYourGear({super.key});

  final userController = Get.find<UserController>();
  final fishingGearController = TextEditingController();

  void callApi() async {
    var data={
      "sortBy": "asc",
      "sortOn": "id",
      "page": 1,
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
      () => userController.getFishGear(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    //callApi();
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(
                  heading: 'Add your gear',
                  textColor: fishColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    runSpacing: 16,
                    spacing: 8,
                    children: List.generate(
                        userController.selectedFishGear.length,
                        (index) => InkWell(
                            borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if(userController.selectedFishGear.contains(userController.selectedFishGear[index])){
                              userController.selectedFishGear.remove(userController.selectedFishGear[index]);
                            }
                          },
                          child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      userController.selectedFishGear[index],
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.close,
                                      color: primaryColor,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: fishingGearController,
                    style: const TextStyle(color: Colors.white),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                        width: 70,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: secondaryColor,
                          ),
                          onPressed: () {
                            if (fishingGearController.text.trim().isNotEmpty) {
                              userController.selectedFishGear
                                  .add(fishingGearController.text.trim());
                              fishingGearController.text="";
                            }
                          },
                          child: const Text('Save',style: TextStyle(color: primaryColor),),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: "Add Fishing Gear",
                      hintStyle: const TextStyle(color: Colors.white54),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
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
            if (userController.selectedFishGear.isEmpty) {
              Get.snackbar('Required!', 'Please add at-least one',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var data = {
              "gear_id": userController.selectedFishGear.join(",").toString(),
            };
            userController.updateOnBoarding(data, 5);
          },
        ),
      ),
    );
  }
}

class FishWidgetItem extends StatelessWidget {
  const FishWidgetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.43,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                fishingImage,
                fit: BoxFit.cover,
                height: 120,
                width: double.infinity,
              )),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: CustomText(
              text: "Fishing Rod",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
