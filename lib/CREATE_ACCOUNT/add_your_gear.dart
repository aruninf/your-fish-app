import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/HOME/main_home.dart';
import 'package:yourfish/UTILS/app_images.dart';
import 'package:yourfish/UTILS/utils.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';


class AddYourGear extends StatelessWidget {
  AddYourGear({super.key});

  final userController = Get.find<UserController>();
  void callApi() async {
    Future.delayed(
      Duration.zero,
          () => userController.getFishGear(),
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
              heading: 'Add your gear',
              textColor: fishColor,
            ),
            const SizedBox(
              height: 16,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SizedBox(
                width: double.infinity,
                height: 30,
                child: CommonButton(
                  onClick: () {

                  },
                  btnBgColor: btnColor,
                  btnText: 'Add',
                  btnTextColor: primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            // Expanded(
            //     child: GridView.builder(
            //       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            //
            //       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           mainAxisSpacing: 16,crossAxisSpacing: 16,
            //           childAspectRatio: 4/5
            //       ),
            //       itemCount: gearData.length,
            //       itemBuilder: (context, index) =>  Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(width: 0.67,color: Colors.white),
            //           borderRadius: BorderRadius.circular(16),
            //
            //         ),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             ClipRRect(
            //                 borderRadius: BorderRadius.circular(16),
            //                 child: Image.asset("${gearData[index].fishImage}",
            //                   height: Get.width*0.45,fit: BoxFit.cover,width: double.infinity,)
            //             ),
            //             Padding(
            //               padding:const EdgeInsets.all(5.0),
            //               child: Text("${gearData[index].fishName}",
            //                 maxLines: 1,
            //                 textAlign:TextAlign.center,style: const TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700
            //
            //                 ),),
            //             )
            //           ],
            //         ),
            //       ),
            //     )
            // )

            Obx(() => Expanded(
                child: userController.isDataLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : userController.fishingGear.isEmpty
                    ? const Center(
                  child: Text("No Record Found!",style: TextStyle(color: Colors.white),),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: userController.fishingGear.length,
                  itemBuilder: (context, index) => Obx(() => Container(
                    width: Get.width,
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: userController.selectedFishGear
                          .contains(userController.fishingGear[index].id) ?fishColor : btnColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        if (userController.selectedFishGear
                            .contains(userController.fishingGear[index].id)) {
                          userController.selectedFishGear
                              .remove(userController.fishingGear[index].id);
                        } else {
                          userController.selectedFishGear
                              .add(userController.fishingGear[index].id);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: CustomText(
                          text: userController.fishingGear[index].title ?? '',
                          sizeOfFont: 16,
                          weight: FontWeight.w800,
                        ),
                      ),
                    ),
                  )),
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
          onClick: () async {
            if (userController.selectedFishGear.isEmpty) {
              Get.snackbar('Required!', 'Select at-least one',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var data={
              "gear_id": userController.selectedFishGear.join(",").toString(),
            };
            userController.updateOnBoarding(data,5);
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
