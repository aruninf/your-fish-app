import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/HOME/home/find_a_buddy_post_item.dart';
import 'package:yourfish/MODELS/post_response.dart';

import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'home/single_post_item.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final postController = Get.find<PostController>();

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
              await postController.getPosts(data);
            },
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: CustomSearchField(
              hintText: 'Search',
              controller: searchController,
              onChanges: (p0) {
                var data = {
                  "sortBy": "desc",
                  "sortOn": "created_at",
                  "page": "1",
                  "limit": "10",
                  "filter": p0
                };
                postController.getPosts(data);
              },
            ),
          ),
          Expanded(
              child: Obx(() => postController.postData.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: postController.postData.length + 1,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      itemBuilder: (context, index) {
                        if (index < postController.postData.length) {
                          return postController.postData[index].type != 2
                              ? SingleFishPostWidget(
                                  postModel: postController.postData[index])
                              : FindABuddyPostItem(
                                  postModel: postController.postData[index],
                                );
                        } else if (index == postController.postData.length &&
                            index > 0) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "No post found!",
                            style: TextStyle(color: secondaryColor),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextButton(
                              onPressed: () async {
                                var data = {
                                  "sortBy": "desc",
                                  "sortOn": "created_at",
                                  "page": "1",
                                  "limit": "10",
                                };
                                searchController.text = "";
                                await postController.getPosts(data);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: fishColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 0)),
                              child: const Text(
                                " Reload ",
                                style: TextStyle(color: btnColor),
                              ))
                        ],
                      ),
                    ))),
        ],
      ),
    );
  }
}
