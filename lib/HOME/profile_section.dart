import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/HOME/profile/my_fish_unlock.dart';
import 'package:yourfish/HOME/profile/my_gear.dart';
import 'package:yourfish/HOME/profile/my_post.dart';
import 'package:yourfish/PROFILE/edit_profile_screen.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../PROFILE/my_future_fish.dart';
import '../PROFILE/my_map_screen.dart';
import '../UTILS/app_color.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({super.key});

  final controller = Get.find<PostController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      extendBody: true,
      body: SafeArea(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 8,
                    contentPadding: EdgeInsets.zero,
                    leading: ClipOval(
                      child: (controller.userData.value.profilePic ?? '')
                              .isNotEmpty
                          ? Image.network(
                              controller.userData.value.profilePic ?? '',
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'images/chat_image2.png',
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            )
                          : Image.asset(
                              'images/chat_image2.png',
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            ),
                    ),
                    title: CustomText(
                      text: controller.userData.value.name ?? '',
                      color: Colors.white,
                      weight: FontWeight.w800,
                      sizeOfFont: 18,
                    ),
                    subtitle: CustomText(
                      text: (controller.userData.value.address ?? '').isNotEmpty
                          ? controller.userData.value.address ?? ''
                          : Get.find<PostController>().currentAddress.value ??
                              '',
                      maxLin: 1,
                      color: Colors.white,
                      sizeOfFont: 15,
                      weight: FontWeight.w500,
                    ),
                    trailing: SizedBox(
                      height: 30,
                      child: TextButton(
                          onPressed: () => Get.to(
                              EditProfileScreen(
                                userData: controller.userData.value,
                              ),
                              transition: Transition.rightToLeft),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                      width: 0.67, color: Colors.white))),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                ),
                controller.selectedIndex.value == 'My Posts'
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Text(
                          'Suggested Friends',
                          style: TextStyle(
                              color: secondaryColor,
                              fontFamily: "Rodetta",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 8,
                ),
                controller.selectedIndex.value == 'My Posts'
                    ? SizedBox(
                        height: Get.height * 0.15,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              controller.listOfProfileSection.length,
                              (index) => Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 0.67, color: Colors.white)),
                                    child: Column(
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            'images/chat_image3.png',
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const CustomText(
                                          text: "Sophie Will",
                                          color: btnColor,
                                          weight: FontWeight.w800,
                                          sizeOfFont: 12,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        SizedBox(
                                          height: 28,
                                          child: TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                  backgroundColor: fishColor,
                                                  padding: EdgeInsets.zero,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8))),
                                              child: const Text(
                                                'Follow',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: Get.height * 0.055,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          controller.listOfProfileSection.length,
                          (index) => Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      controller.listOfProfileSection[index] ==
                                              controller.selectedIndex.value
                                          ? secondaryColor
                                          : btnColor,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedIndex.value =
                                        controller.listOfProfileSection[index];
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: CustomText(
                                      text: controller
                                          .listOfProfileSection[index],
                                      weight: FontWeight.w700,
                                      sizeOfFont: 13,
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
                Expanded(
                    child: controller.selectedIndex.value == "My Posts"
                        ? MyPostWidget()
                        : controller.selectedIndex.value == "My Map"
                            ? MyProfileMapWidget(
                                isTopSpots: false,
                              )
                            : controller.selectedIndex.value == "Fish Unlocked"
                                ? MyFishUnlockedWidget()
                                : controller.selectedIndex.value ==
                                        "My Future Fish"
                                    ? MyFutureFishWidget()
                                    : MyGearWidget()),
              ],
            )),
      ),
    );
  }
}
