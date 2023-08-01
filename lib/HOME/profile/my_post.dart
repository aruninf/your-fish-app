import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_POST/add_fish_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';

class MyPostWidget extends StatelessWidget {
  MyPostWidget({super.key});

  final controller = Get.find<PostController>();



  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : controller.myPostData.isEmpty
            ? const Center(
                child: Text(
                  "Not Post Yet!",
                  style: TextStyle(color: secondaryColor),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: controller.myPostData.length,
                itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.network(
                          controller.myPostData[index].image ?? '',
                          height: Get.width * 0.32,
                          width: Get.width * 0.32,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            fishingImage,
                            height: Get.width * 0.32,
                            width: Get.width * 0.32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => Get.to(()=>AddFishScreen()),
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: fishColor),
                                    child: const Icon(
                                      CupertinoIcons.eyedropper,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ),
                              const Spacer(),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  /// Confirmation Dialog/////////////////////////
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
                                          children: [
                                            const Text(
                                              'Delete Post',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              'Are you sure want to delete post?',
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
                                                      "id": controller
                                                          .myPostData[index].id
                                                    };
                                                    controller.deletePost(data);

                                                    if (Get.isDialogOpen!) {
                                                      Get.back();
                                                    }
                                                    controller
                                                        .myPostData.removeAt(index);
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
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: fishColor),
                                    child: const Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ));
  }
}
