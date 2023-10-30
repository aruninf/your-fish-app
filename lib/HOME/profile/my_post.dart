import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_POST/add_fish_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/image_place_holder_widget.dart';
import '../home/empty_post_widget.dart';
import '../home/find_a_buddy_post_item.dart';
import '../home/single_post_item.dart';

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
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.myPostData.length + 1,
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 0),
          itemBuilder: (context, index) {
            if (index < controller.myPostData.length) {
              return controller.myPostData[index].type != 2
                  ? SingleFishPostWidget(
                  postModel: controller.myPostData[index],index: index,)
                  : FindABuddyPostItem(
                postModel: controller.myPostData[index],index: index,
              );
            } else if (index == controller.myPostData.length &&
                index > 0) {
              return FutureBuilder(
                future:
                Future.delayed(const Duration(seconds: 5)),
                builder: (context, snapshot) =>
                snapshot.connectionState ==
                    ConnectionState.done
                    ? const SizedBox.shrink()
                    : const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
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



