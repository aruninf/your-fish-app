import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_POST/add_fish_screen.dart';
import 'package:yourfish/PROFILE/post_detail_screen.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../CUSTOM_WIDGETS/image_place_holder_widget.dart';
import '../../MODELS/post_response.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';

class SingleFishPostWidget extends StatelessWidget {
  SingleFishPostWidget({super.key, required this.postModel, required this.index});

  final PostData postModel;
  final controller = Get.find<PostController>();
  final int index;
  var isLiked=false.obs;
  var isFav=false.obs;

  void getData(){
    Future.delayed(Duration.zero,() {
      isLiked.value = postModel.isLiked ?? false;
      isFav.value = postModel.isFavourite ?? false;
    },);
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return InkWell(
      onTap: () => Get.to(() => PostDetailScreen(postModel: postModel)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white70, width: .67)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    postModel.userHandle!.contains("@")
                        ? "${postModel.userHandle}"
                        : "@${postModel.userHandle}",
                    style: const TextStyle(
                        fontFamily: "Rodetta",
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: secondaryColor),
                  ),
                ),
                const Spacer(),
                (postModel.isPublic == 1)
                    ? TextButton.icon(
                    onPressed: () {},
                    style:
                    TextButton.styleFrom(alignment: Alignment.topRight),
                    icon: const Icon(
                      PhosphorIcons.map_pin,
                      color: Colors.white,
                      size: 16,
                    ),
                    label: CustomText(
                      text: (postModel.address ?? '')
                          .split(",")
                          .first,
                      weight: FontWeight.w400,
                      sizeOfFont: 13,
                      maxLin: 1,
                      color: Colors.white,
                    ))
                    : const SizedBox.shrink(),
                GestureDetector(
                  onTapDown: (de) {
                    if (controller.userData.value.id != postModel.userId) {
                      modalBottomSheetMenu(context);
                    } else {
                      controller.showPopupMenuForEditPost(context, de, postModel,index,2);
                    }
                  },
                  child: const Icon(
                    Icons.more_vert_rounded,
                    color: fishColor,
                  ),
                )
              ],
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "${postModel.image}",
                  width: double.infinity,
                  height: Get.height * 0.4,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      ImagePlaceHolderWidget(
                        width: double.infinity,
                        height: Get.height * 0.4,
                      ),
                )),
            Obx(() {

              return Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: (){
                      isLiked.value=!isLiked.value;

                      controller.addLiked(postModel,isLiked.value);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        isLiked.value
                            ? fishIcon
                            : fishIcon,
                        color: isLiked.value
                            ? fishColor
                            : Colors.white,
                        width: 32,height: 32,

                      ),
                    ),
                  ),
                  controller.userData.value.id != postModel.userId
                      ? InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      final data = {
                        "post_id": postModel.id,
                        "page": 1,
                        "limit": 20
                      };
                      controller.getPostComment(data);
                      controller.openComment(
                          context, "${postModel.id}");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        PhosphorIcons.chat,
                        color: Colors.white,
                      ),
                    ),
                  )
                      : const SizedBox.shrink(),
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => controller.sharePost(postModel),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        PhosphorIcons.share_network,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      isFav.value=!isFav.value;
                      controller.addFavourite(postModel,isFav.value);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isFav.value
                            ? PhosphorIcons.bookmark_simple_fill
                            : PhosphorIcons.bookmark_simple,
                        color:
                        isFav.value ? fishColor : Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }),
            CustomText(
              text: postModel.caption ?? '',
              weight: FontWeight.w600,
              sizeOfFont: 14,
              maxLin: 2,
              color: Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
                children: List.generate(
                  (postModel.tagFish ?? []).length,
                      (index) =>
                      Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(16)),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: CustomText(
                          text: "#${(postModel.tagFish ?? [])[index]
                              .localName}",
                          weight: FontWeight.w700,
                          sizeOfFont: 13,
                          color: secondaryColor,
                        ),
                      ),
                ))
          ],
        ),
      ),
    );
  }

  void modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: primaryColor,
        builder: (builder) {
          return SafeArea(
              child: Container(
                padding:
                const EdgeInsets.only(top: 4, right: 16, left: 16, bottom: 16),
                height: Get.height * 0.4,
                width: Get.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Report Post",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.close,
                              color: secondaryColor,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.3,
                      width: Get.width,
                      child: ListView(
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                reportPost("Hate Speech or Discrimination");
                              },
                              child: const Text(
                                "Hate Speech or Discrimination",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: secondaryColor),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                reportPost("Harassment or Bullying");
                              },
                              child: const Text(
                                "Harassment or Bullying",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: secondaryColor),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                reportPost("Graphic or Violent Content");
                              },
                              child: const Text(
                                "Graphic or Violent Content",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: secondaryColor),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                reportPost("Nudity or Adult Content");
                              },
                              child: const Text(
                                "Nudity or Adult Content",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: secondaryColor),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                reportPost("Misinformation or Fake News");
                              },
                              child: const Text(
                                "Misinformation or Fake News",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: secondaryColor),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  void reportPost(String reason) {
    Get.back();
    var data = {"post_id": postModel.id, "reason": reason};
    Get.find<PostController>().reportPost(data);
  }




}
