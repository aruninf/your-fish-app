import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CREATE_POST/add_fish_screen.dart';
import '../../CUSTOM_WIDGETS/cached_image_view.dart';
import '../../PROFILE/post_detail_screen.dart';
import '../home/empty_post_widget.dart';

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
    return Obx(() => controller.myPostData.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              page = 1;
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "page": page,
                "limit": "10",
              };
              controller.getMyPost(data);
            },
            child: GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: controller.myPostData.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Get.to(() =>
                    PostDetailScreen(postModel: controller.myPostData[index])),
                borderRadius: BorderRadius.circular(16),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomCachedImage(
                          imageUrl: controller.myPostData[index].image ?? '',
                          height: Get.width * 0.32,
                          width: Get.width * 0.32,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                  bottom: Radius.circular(16)),
                              color: Colors.black54),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => Get.to(AddFishScreen(
                                  postData: controller.myPostData[index],
                                )),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    CupertinoIcons.create,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              Spacer(),
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
                                                    controller.myPostData
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
                        )
                      ],
                    )),
              ),
            ))
        : EmptyPostWidget(
            onClick: () async {
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "page": 1,
                "limit": "10",
              };
              await controller.getMyPost(data);
            },
          ));
  }
}
