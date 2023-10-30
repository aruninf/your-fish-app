import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../CONTROLLERS/post_controller.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../CUSTOM_WIDGETS/image_place_holder_widget.dart';
import '../MODELS/post_response.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key, required this.postModel});

  final PostData postModel;
  final controller = Get.find<PostController>();
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
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: "Post Detail",
              textColor: secondaryColor,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                          ? SizedBox(
                              width: Get.width * 0.35,
                              child: TextButton.icon(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      alignment: Alignment.topRight),
                                  icon: const Icon(
                                    PhosphorIcons.map_pin,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  label: CustomText(
                                    text: postModel.address ?? '',
                                    weight: FontWeight.w400,
                                    sizeOfFont: 13,
                                    maxLin: 1,
                                    color: Colors.white,
                                  )),
                            )
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
                            onTap: () {
                              isLiked.value=!isLiked.value;

                              controller.addLiked(postModel,isLiked.value);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:  Image.asset(
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
                          controller.userData.value.id!=postModel.userId ? InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => controller.openChat("${postModel.userId}"),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                PhosphorIcons.chat,
                                color: Colors.white,
                              ),
                            ),
                          ): const SizedBox.shrink(),
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
                                color: isFav.value
                                    ? fishColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Wrap(
                      children: List.generate(
                    (postModel.tagFish ?? []).length,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: CustomText(
                        text: "#${(postModel.tagFish ?? [])[index].localName}",
                        weight: FontWeight.w700,
                        sizeOfFont: 13,
                        color: secondaryColor,
                      ),
                    ),
                  )),
                  CustomText(
                    text: postModel.caption ?? '',
                    weight: FontWeight.w600,
                    sizeOfFont: 14,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
