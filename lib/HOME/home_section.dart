import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/HOME/home/empty_post_widget.dart';
import 'package:yourfish/HOME/home/find_a_buddy_post_item.dart';

import '../CUSTOM_WIDGETS/custom_search_field.dart';
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
                "type": 1
              };
              await postController.getPosts(data);
            },
          );
        });
      }
    });

    Future.delayed(
      Duration.zero,
      () async {
        var data = {
          "sortBy": "desc",
          "sortOn": "created_at",
          "page": 1,
          "limit": 20,
          "type": 2
        };
        await postController.getPostsBuddy(data);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: RefreshIndicator(
        onRefresh: () async {
          // Handle refresh logic here

          page = 1;
          var data = {
            "sortBy": "desc",
            "sortOn": "created_at",
            "page": page,
            "limit": "10",
            "type": 1
          };
          postController.getPosts(data);
        },
        child: Obx(() => postController.postData.isNotEmpty
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: CustomSearchField(
                        hintText: 'Search',
                        controller: searchController,
                        onChanges: (p0) {
                          page = 1;
                          var data = {
                            "sortBy": "desc",
                            "sortOn": "created_at",
                            "page": page,
                            "limit": "10",
                            "type": 1,
                            "filter": p0
                          };
                          postController.getPosts(data);
                          searchController.text = "";
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(() => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                postController.findBuddyPost.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 8),
                                  child: FindABuddyPostItem(
                                    postModel:
                                        postController.findBuddyPost[index],
                                    index: index,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index < postController.postData.length) {
                            return SingleFishPostWidget(
                              postModel: postController.postData[index],
                              index: index,
                            );
                          } else if (index == postController.postData.length &&
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
                            return EmptyPostWidget(
                              onClick: () {
                                page = 1;
                                var data = {
                                  "sortBy": "desc",
                                  "sortOn": "created_at",
                                  "page": page,
                                  "limit": 10,
                                  "type": 1,
                                };
                                postController.getPosts(data);
                              },
                            );
                          }
                        },
                        childCount: postController.postData.length + 1,
                      ),
                    ),
                  ],
                ),
              )
            : EmptyPostWidget(
                onClick: () {
                  page = 1;
                  var data = {
                    "sortBy": "desc",
                    "sortOn": "created_at",
                    "page": page,
                    "limit": 10,
                    "type": 1,
                  };
                  postController.getPosts(data);
                },
              )),
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
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
                  page = 1;
                  var data = {
                    "sortBy": "desc",
                    "sortOn": "created_at",
                    "page": page,
                    "limit": "10",
                    "type": 1,
                    "filter": p0
                  };
                  postController.getPosts(data);
                  searchController.text = "";
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        postController.findBuddyPost.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: FindABuddyPostItem(
                                postModel: postController.findBuddyPost[index],
                                index: index,
                              ),
                            )),
                  )),
            ),
            Obx(() => postController.postData.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      page = 1;
                      var data = {
                        "sortBy": "desc",
                        "sortOn": "created_at",
                        "page": page,
                        "limit": "10",
                        "type": 1
                      };
                      postController.getPosts(data);
                    },
                    child: ListView.builder(
                      //controller: scrollController,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: postController.postData.length + 1,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      itemBuilder: (context, index) {
                        if (index < postController.postData.length) {
                          return SingleFishPostWidget(
                            postModel: postController.postData[index],
                            index: index,
                          );
                        } else if (index == postController.postData.length &&
                            index > 0) {
                          return FutureBuilder(
                            future: Future.delayed(const Duration(seconds: 5)),
                            builder: (context, snapshot) =>
                                snapshot.connectionState == ConnectionState.done
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
                        "type": 1
                      };
                      await postController.getPosts(data);
                    },
                  )),
          ],
        ),
      ),
    );
  }*/
}
