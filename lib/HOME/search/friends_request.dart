import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CONTROLLERS/user_controller.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';


class FriendRequestScreen extends StatelessWidget {
  FriendRequestScreen({super.key});

  final controller = Get.find<UserController>();

  void getFriendRequest() {
    var data = {
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": 1,
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
          () => controller.getFriendRequest(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    getFriendRequest();
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: "Friend Requests",
              textColor: secondaryColor,
            ),
            Expanded(
              child: Obx(() => controller.isDataLoading.value
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : controller.friendRequest.isNotEmpty
                  ? ListView.builder(
                itemCount: controller.friendRequest.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 8, right: 8),
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  leading: ClipOval(
                    child: Image.network(
                      controller.friendRequest[index].profilePic ??
                          '',
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
                    text: controller.friendRequest[index].name ?? '',
                    color: Colors.white,
                  ),
                  //subtitle: const CustomText(text: '@a.brown',color: Colors.white,),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextButton(
                            onPressed: () {
                              var data = {
                                "request_to":  controller.friendRequest[index].id,
                                "request_status": 3
                              };
                              controller.sendRequest(data,2);
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: fishColor,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(8))),
                            child: const Text(
                              'Accept',
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
                            onPressed: () {
                              var data = {
                                "request_to":  controller.friendRequest[index].id,
                                "request_status": 4
                              };
                              controller.sendRequest(data,2);
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    side: const BorderSide(
                                        width: 1,
                                        color: Colors.white))),
                            child: const Text(
                              'Deny',
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
                  "No Friend Request!",
                  style: TextStyle(color: secondaryColor),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
