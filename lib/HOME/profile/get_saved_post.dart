import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/setting_controller.dart';
import 'package:yourfish/CREATE_POST/add_fish_screen.dart';
import 'package:yourfish/HOME/home/empty_post_widget.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../PROFILE/post_detail_screen.dart';

class SavedPostWidget extends StatelessWidget {
  SavedPostWidget({super.key});
  final controller = Get.find<SettingController>();

  callSavedPostApi() async {
    var data = {
      "sortBy": "desc",
      "sortOn": "created_at",
      "page": 1,
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
          () => controller.getSavedPost(data),
    );

  }

  @override
  Widget build(BuildContext context) {
    callSavedPostApi();
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: "Saved Posts",
              textColor: secondaryColor,
            ),
            Expanded(
              child: Obx(() => controller.isLoading.value
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : controller.savedPost.isEmpty
                  ? EmptyPostWidget(
                onClick: ()=>callSavedPostApi,
              )
                  : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: controller.savedPost.length,
                itemBuilder: (context, index) => InkWell(
                  //onTap: () => Get.to(PostDetailScreen(postModel: controller.savedPost[index])),
                  borderRadius: BorderRadius.circular(16),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network(
                            controller.savedPost[index].image ?? '',
                            height: Get.width * 0.32,
                            width: Get.width * 0.32,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  fishingImage,
                                  height: Get.width * 0.32,
                                  width: Get.width * 0.32,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ],
                      )),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

}
