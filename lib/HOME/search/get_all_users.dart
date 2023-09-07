import 'package:flutter/material.dart';

import '../../CHATS/one_to_one_chat_screen.dart';
import '../../CONTROLLERS/user_controller.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';

class GetAllUserWidget extends StatefulWidget {
  GetAllUserWidget({super.key});

  @override
  State<GetAllUserWidget> createState() => _GetAllUserWidgetState();
}

class _GetAllUserWidgetState extends State<GetAllUserWidget> {
  final controller = Get.find<UserController>();

  final searchController=TextEditingController().obs;


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
                "limit": "10",
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
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": page,
      "limit": "10",
      "filter": ""
    };
    Future.delayed(
      Duration.zero,
      () => controller.getAllUsers(data),
    );
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
            onChanges: (p0) {
              var data = {
                "sortBy": "asc",
                "sortOn": "created_at",
                "page": "1",
                "limit": "20",
                "filter": searchController.value.text
              };
              Future.delayed(
                Duration.zero,
                    () => controller.getAllUsers(data),
              );
            },
          ),
        ),
        Expanded(
          child: Obx(() => controller.allUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.allUsers.length,
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 8, left: 8, right: 8),
                      itemBuilder: (context, index) => ListTile(
                        onTap: () => Get.to(() => const OneToOneChatScreen(),
                            transition: Transition.rightToLeft),
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
                                Image.asset(
                              fishPlaceHolder,
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
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
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                  onPressed: () async {
                                    var data = {
                                      "request_sent_to": controller.allUsers[index].id,
                                      "followed_person_id": controller.allUsers[index].id,
                                      "follow_unfollow_status": 1
                                    };
                                    controller.userFollowUnfollow(data);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: fishColor,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: const Text(
                                    'Follow',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                  onPressed: () => controller.openChat(controller.allUsers[index]),
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
