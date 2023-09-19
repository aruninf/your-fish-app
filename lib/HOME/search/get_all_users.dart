import 'package:flutter/material.dart';
import 'package:yourfish/CUSTOM_WIDGETS/image_place_holder_widget.dart';

import '../../CHATS/one_to_one_chat_screen.dart';
import '../../CONTROLLERS/user_controller.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';

class GetAllUserWidget extends StatefulWidget {
  const GetAllUserWidget({super.key});

  @override
  State<GetAllUserWidget> createState() => _GetAllUserWidgetState();
}

class _GetAllUserWidgetState extends State<GetAllUserWidget> {
  final controller = Get.find<UserController>();

  final searchController = TextEditingController().obs;

  final scrollController = ScrollController();
  var page = 1;

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
                "limit": "20",
              };
              await controller.getAllUsers(data);
            },
          );
        });
      }
    });
    super.initState();
    getAllUsers();
  }

  void getAllUsers() {
    var data = {
      "sortBy": "desc",
      "sortOn": "id",
      "page": page,
      "limit": "20",
    };
    Future.delayed(
      Duration.zero,
      () => controller.getAllUsers(data),
    );
    searchController.value.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: CustomSearchField(
            hintText: 'Search',
            controller: searchController.value,
            isClearIcon: true,
            onChanges: (p0) {
              var data = {
                "sortBy": "asc",
                "sortOn": "created_at",
                "page": 1,
                "limit": "20",
                "filter": p0
              };
              Future.delayed(
                Duration.zero,
                () => controller.getAllUsers(data),
              );
            },
            clear: getAllUsers,
          ),
        ),
        Expanded(
          child: Obx(() => controller.allUsers.isNotEmpty
              ? RefreshIndicator(
                  child: ListView.builder(
                    itemCount: controller.allUsers.length,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 8, left: 8, right: 8),
                    itemBuilder: (context, index) => ListTile(
                      // onTap: () =>
                      //     Get.to(() => const OneToOneChatScreen(),
                      //         transition: Transition.rightToLeft),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1),
                      leading: ClipOval(
                        child: Image.network(
                          '${controller.allUsers[index].profilePic}',
                          height: 48,
                          width: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const ImagePlaceHolderWidget(
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ),
                      title: CustomText(
                        text: '${controller.allUsers[index].name}',
                        color: Colors.white,
                      ),
                      subtitle: CustomText(
                        text: '${controller.allUsers[index].handle}',
                        color: Colors.white,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// When user deny your friend request Status = 4 Follow button will hide
                          controller.allUsers[index].followingStatus == 4
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: 30,
                                  child: TextButton(
                                      onPressed: () async {
                                        var data = {
                                          "request_to":
                                              controller.allUsers[index].id,
                                          "request_status": (controller
                                                          .allUsers[index]
                                                          .followingStatus ==
                                                      0 ||
                                                  controller.allUsers[index]
                                                          .followingStatus ==
                                                      2)
                                              ? 1
                                              : 2
                                        };
                                        if (controller.allUsers[index]
                                                .followingStatus !=
                                            3) {
                                          controller.sendRequest(data, 1);
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
                                        (controller.allUsers[index]
                                                        .followingStatus ==
                                                    0 ||
                                                controller.allUsers[index]
                                                        .followingStatus ==
                                                    2)
                                            ? 'Follow'
                                            : controller.allUsers[index]
                                                        .followingStatus ==
                                                    1
                                                ? "Unfollow"
                                                : "Following",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 30,
                            child: TextButton(
                                onPressed: () => controller
                                    .openChat(controller.allUsers[index]),
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
                  onRefresh: () async {
                    getAllUsers();
                  },
                )
              : const Center(
                  child: Text(
                    "No Record Found!",
                    style: TextStyle(color: secondaryColor),
                  ),
                )),
        ),
      ],
    );
  }
}
