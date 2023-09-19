import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_POST/add_fish_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/image_place_holder_widget.dart';

class MyPostWidget extends StatefulWidget {
  MyPostWidget({super.key, required this.myPost});

  final bool myPost;

  @override
  State<MyPostWidget> createState() => _MyPostWidgetState();
}

class _MyPostWidgetState extends State<MyPostWidget> {
  final controller = Get.find<PostController>();

  final scrollController = ScrollController();
  var page = 1;
  var searchController = TextEditingController();

  @override
  void initState() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        setState(() {
          page += 1;
          //add api for load the more data according to new page
          Future.delayed(
            Duration.zero,
            () async {
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "page": page,
                "limit": "10",
              };
              await controller.getMyPost(data);
            },
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.myPostData.isEmpty
        ? const Center(
            child: Text(
              "Not Post Yet!",
              style: TextStyle(color: secondaryColor),
            ),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: controller.myPostData.length,
            itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    controller.myPostData[index].type == 1
                        ? Image.network(
                            controller.myPostData[index].image ?? '',
                            height: Get.width * 0.32,
                            width: Get.width * 0.32,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                ImagePlaceHolderWidget(
                              height: Get.width * 0.32,
                              width: Get.width * 0.32,
                            ),
                          )
                        : Container(
                            height: Get.width * 0.32,
                            width: Get.width * 0.32,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  controller.myPostData[index].caption ?? '',
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: primaryColor, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                    widget.myPost
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => Get.to(() => AddFishScreen()),
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.transparent),
                                      child: const SizedBox.shrink()),
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                            .myPostData[index]
                                                            .id
                                                      };
                                                      controller
                                                          .deletePost(data);

                                                      if (Get.isDialogOpen!) {
                                                        Get.back();
                                                      }
                                                      controller.myPostData
                                                          .removeAt(index);
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                        : const SizedBox.shrink()
                  ],
                )),
          ));
  }
}
