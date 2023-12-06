import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/CUSTOM_WIDGETS/cached_image_view.dart';
import 'package:yourfish/MODELS/user_response.dart';
import 'package:yourfish/PROFILE/post_detail_screen.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../CUSTOM_WIDGETS/image_place_holder_widget.dart';
import '../HOME/home/empty_post_widget.dart';
import '../UTILS/app_color.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key, required this.user});

  final UserData user;

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final controller = Get.find<PostController>();
  final userController = Get.find<UserController>();

  void getData() async {
    var data = {
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": 1,
      "limit": 20,
      "type": 1,
      "user_id": widget.user.id
    };

    Future.delayed(
      Duration.zero,
      () {
        controller.getUserPosts(data);
      },
    );
  }

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
                "limit": 20,
                "type": 1,
                "user_id": widget.user.id
              };
              await controller.getUserPosts(data);
            },
          );
        });
      }
    });
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: '',
              textColor: secondaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: ListTile(
                dense: true,
                horizontalTitleGap: 8,
                contentPadding: EdgeInsets.zero,
                leading: ClipOval(
                  child: (widget.user.profilePic ?? '').isNotEmpty
                      ? CustomCachedImage(
                          imageUrl: widget.user.profilePic ?? '',
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        )
                      : const ImagePlaceHolderWidget(
                          height: 50,
                          width: 50,
                        ),
                ),
                title: CustomText(
                  text: widget.user.name ?? '',
                  color: Colors.white,
                  weight: FontWeight.w800,
                  sizeOfFont: 18,
                ),
                subtitle: CustomText(
                  text: '${widget.user.handle}',
                  maxLin: 1,
                  color: Colors.white,
                  sizeOfFont: 15,
                  weight: FontWeight.w500,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// When user deny your friend request Status = 4 Follow button will hide
                    widget.user.followingStatus == 4
                        ? const SizedBox.shrink()
                        : Obx(() => SizedBox(
                              height: 30,
                              child: TextButton(
                                  onPressed: () async {
                                    controller.isFollow.value =
                                        !controller.isFollow.value;

                                    /// Follow 0, unfollow 1 following 2
                                    var data = {
                                      "request_to": widget.user.id,
                                      "request_status":
                                          (widget.user.followingStatus == 0 ||
                                                  widget.user.followingStatus ==
                                                      2)
                                              ? 1
                                              : 2
                                    };
                                    if (widget.user.followingStatus != 3) {
                                      userController.sendRequest(data, 1);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: fishColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: Text(
                                    controller.isFollow.value
                                        ? widget.user.followingStatus != 0
                                            ? "Unfollow"
                                            : 'Following'
                                        : "Follow",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600),
                                  )),
                            )),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 30,
                      child: TextButton(
                          onPressed: () =>
                              controller.openChat(widget.user.id.toString()),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                      width: 1, color: Colors.white))),
                          child: const Text(
                            'Chat',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                  controller.getPosts(data);
                  searchController.text = "";
                },
              ),
            ),
            Expanded(
              child: Obx(() => controller.userPostData.isEmpty
                  ? EmptyPostWidget(
                      onClick: () async {
                        var data = {
                          "sortBy": "desc",
                          "sortOn": "created_at",
                          "page": 1,
                          "limit": 10,
                        };
                        await controller.getUserPosts(data);
                      },
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        var data = {
                          "sortBy": "desc",
                          "sortOn": "created_at",
                          "page": 1,
                          "limit": 10,
                        };
                        controller.getUserPosts(data);
                      },
                      child: GridView.builder(
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        itemCount: controller.userPostData.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => Get.to(() => PostDetailScreen(
                              postModel: controller.userPostData[index])),
                          borderRadius: BorderRadius.circular(16),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CustomCachedImage(
                                imageUrl:
                                    controller.userPostData[index].image ?? '',
                                height: Get.width * 0.32,
                                width: Get.width * 0.32,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
