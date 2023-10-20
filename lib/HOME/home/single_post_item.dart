import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/PROFILE/post_detail_screen.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../CUSTOM_WIDGETS/image_place_holder_widget.dart';
import '../../MODELS/post_response.dart';
import '../../UTILS/app_color.dart';

class SingleFishPostWidget extends StatelessWidget {
  SingleFishPostWidget({super.key, required this.postModel});

  final PostData postModel;
  final controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    //controller.isLiked.value=postModel.isLiked ?? false;
    //controller.isFav.value=postModel.isFavourite ?? false;
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
                          text: (postModel.address ?? '').split(",").first,
                          weight: FontWeight.w400,
                          sizeOfFont: 13,
                          maxLin: 1,
                          color: Colors.white,
                        ))
                    : const SizedBox.shrink()
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
            Obx(() => Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => controller.addLiked(postModel),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          controller.isLiked.value
                              ? PhosphorIcons.thumbs_up_fill
                              : PhosphorIcons.thumbs_up,
                          color: controller.isLiked.value
                              ? fishColor
                              : Colors.white,
                        ),
                      ),
                    ),
                    controller.userData.value.id != postModel.userId
                        ? InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () =>
                                controller.openChat("${postModel.userId}"),
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
                      onTap: () => controller.addFavourite(postModel),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          controller.isFav.value
                              ? PhosphorIcons.bookmark_simple_fill
                              : PhosphorIcons.bookmark_simple,
                          color:
                              controller.isFav.value ? fishColor : Colors.white,
                        ),
                      ),
                    ),
                  ],
                )),
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
              (index) => Container(
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: CustomText(
                  text: "#${(postModel.tagFish ?? [])[index].localName}",
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
}
