import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/MODELS/user_response.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/cached_image_view.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MODELS/post_response.dart';
import '../../PROFILE/view_profile_screen.dart';
import '../../UTILS/app_color.dart';

class FindABuddyPostItem extends StatelessWidget {
  FindABuddyPostItem({super.key, required this.postModel, required this.index});

  final controller = Get.find<PostController>();

  final PostData postModel;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width * 0.935,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white70, width: .67)),
        child: ListTile(
          onTap: () => Get.to(ViewProfileScreen(
            user: UserData(
                name: postModel.userName,
                id: postModel.userId,
                handle: postModel.userHandle,
                followingStatus: postModel.followingStatus,
                profilePic: postModel.userProfilePic),
          )),
          leading: ClipOval(
            child: CustomCachedImage(
              imageUrl: postModel.userProfilePic ?? '',
              height: 35,
              width: 35,
              fit: BoxFit.cover,
            ),
          ),
          title: GestureDetector(
            onTap: () => Get.to(ViewProfileScreen(
              user: UserData(
                  name: postModel.userName,
                  id: postModel.userId,
                  handle: postModel.userHandle,
                  followingStatus: postModel.followingStatus,
                  profilePic: postModel.userProfilePic),
            )),
            child: Text(
              postModel.userHandle!.contains("@")
                  ? "${postModel.userHandle}"
                  : "@${postModel.userHandle}",
              style: const TextStyle(
                  fontFamily: "Rodetta",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: secondaryColor),
            ),
          ),
          subtitle: CustomText(
            text: postModel.caption ?? '',
            weight: FontWeight.w600,
            sizeOfFont: 12,
            color: Colors.white,
          ),
          trailing: controller.userData.value.id != postModel.userId
              ? SizedBox(
                  height: 30,
                  child: TextButton(
                    onPressed: () => controller.openChat("${postModel.userId}"),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side:
                                const BorderSide(width: 1, color: fishColor))),
                    child: const Text(
                      "CHAT",
                      style: TextStyle(
                          fontFamily: "Rodetta",
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                  ),
                )
              : GestureDetector(
                  onTapDown: (de) {
                    controller.showPopupMenuForEditPost(
                        context, de, postModel, index, 1);
                  },
                  child: const Icon(
                    Icons.more_vert_rounded,
                    color: fishColor,
                  ),
                ),
        ));
  }
}
