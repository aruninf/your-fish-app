import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CONTROLLERS/post_controller.dart';
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
                    child: CustomCachedImage(
                      imageUrl: controller.myPostData[index].image ?? '',
                      height: Get.width * 0.32,
                      width: Get.width * 0.32,
                      fit: BoxFit.cover,
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
