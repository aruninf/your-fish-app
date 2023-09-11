import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_POST/add_fish_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../PROFILE/post_detail_screen.dart';
import '../home/empty_post_widget.dart';

class AllPostWidget extends StatefulWidget {
  const AllPostWidget({super.key});

  @override
  State<AllPostWidget> createState() => _AllPostWidgetState();
}

class _AllPostWidgetState extends State<AllPostWidget> {
  final controller = Get.find<PostController>();

  final listOfBeach = [
    "Mermaid Beach",
    "Palm Beach",
    "Bondi Beach",
    "Manly Beach,",
    "Lizard Island"
  ];

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
              await controller.getPosts(data);
            },
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: CustomSearchField(
            hintText: 'Search',
            onChanges: (p0) {
              page = 1;
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "page": page,
                "limit": "10",
                "filter": p0
              };
              controller.getPosts(data);
              searchController.text = "";
            },
          ),
        ),
        Expanded(
          child: Obx(() => controller.postData.isEmpty
              ? EmptyPostWidget(
            onClick: () async {
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "page": 1,
                "limit": "10",
              };
              await controller.getPosts(data);
            },
          )
              : RefreshIndicator(
                  onRefresh: () async {
                    var data = {
                      "sortBy": "desc",
                      "sortOn": "created_at",
                      "page": 1,
                      "limit": "10",
                    };
                    controller.getPosts(data);
                  },
                  child: GridView.builder(
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: controller.postData.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Get.to(PostDetailScreen(postModel: controller.postData[index])),
                      borderRadius: BorderRadius.circular(16),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            controller.postData[index].image ?? '',
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
                          )),
                    ),
                  ),
                )),
        ),
      ],
    );
  }
}
