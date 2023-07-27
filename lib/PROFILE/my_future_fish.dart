import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/UTILS/app_images.dart';
import 'package:yourfish/UTILS/consts.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../UTILS/app_color.dart';

class MyFutureFishWidget extends StatelessWidget {
  MyFutureFishWidget({super.key});

  final controller = Get.find<UserController>();

  void getMyFutureFish(){
    var data={
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(Duration.zero,() => controller.getFish(data),);
  }
  @override
  Widget build(BuildContext context) {
    getMyFutureFish();
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 5 / 4),
      itemCount: controller.fishData.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.67, color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            Get.dialog(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
                          color: primaryColor,
                          child: Column(
                            children: [
                              IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: Colors.white30),
                                  onPressed: () => Get.back(),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )),
                              const SizedBox(height: 10),
                              const Text(
                                "New fish unlocked!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: secondaryColor,
                                    fontFamily: 'Rodetta',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Congratulation! you have new fish on your list!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                              //Buttons
                              Container(
                                width: Get.width,
                                height: 55,
                                margin: const EdgeInsets.all(16),
                                child: CommonButton(
                                  btnBgColor: secondaryColor,
                                  btnTextColor: primaryColor,
                                  btnText: "Add to List",
                                  onClick: () => Get.back(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        controller.fishData[index].fishImage ?? '',
                        height: Get.width * 0.25,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          fishingImage,
                          height: Get.width * 0.25,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )),
                  const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          PhosphorIcons.lock_bold,
                          color: secondaryColor,
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.fishData[index].localName ?? 'Your fish name',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
