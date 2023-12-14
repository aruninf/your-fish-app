import 'package:flutter/cupertino.dart';
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
      "page": 1,
      "limit": 20
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

                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:16,vertical: 10 ),
                                child: CustomText(
                                  text: controller.fishingGear[index].title ?? '',
                                  sizeOfFont: 16,
                                  weight: FontWeight.w800,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.dialog(
                                    Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 16,
                                            bottom: 8,
                                            left: 16,
                                            right: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Delete Gear',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,color: Colors.redAccent),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              'Are you sure want to delete this gear?',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (Get.isDialogOpen!)
                                                      Get.back();
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    var data = {
                                                      "name": controller
                                                          .fishingGear[index].title
                                                    };
                                                    controller.deleteGear(data);

                                                    if (Get.isDialogOpen!) {
                                                      Get.back();
                                                    }
                                                    controller.fishingGear
                                                        .removeAt(index);
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    CupertinoIcons.trash,
                                    color: Colors.redAccent,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
    );
  }
}
