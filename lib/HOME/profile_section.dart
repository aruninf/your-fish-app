import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/PROFILE/edit_profile_screen.dart';
import 'package:yourfish/UTILS/consts.dart';

import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../PROFILE/my_future_fish.dart';
import '../PROFILE/my_map_screen.dart';
import '../UTILS/app_color.dart';

class ProfileSection extends StatefulWidget {
  ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}


class _ProfileSectionState extends State<ProfileSection> {
  String? selectedIndex = "My Posts";
  final listOfProfileSection = [
    "My Posts",
    "My Map",
    "Fish Unlocked",
    "My Future Fish",
    "My Gear"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      extendBody: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: ListTile(
                dense: true,
                horizontalTitleGap: 8,
                contentPadding: EdgeInsets.zero,
                leading: ClipOval(
                  child: Image.asset(
                    'images/chat_image2.png',
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
                title: const CustomText(
                  text: 'Alex Brown',
                  color: Colors.white,
                  weight: FontWeight.w800,
                  sizeOfFont: 18,
                ),
                subtitle: const CustomText(
                  text: 'Gold Cost, au',
                  color: Colors.white,
                  sizeOfFont: 15,
                  weight: FontWeight.w500,
                ),
                trailing: SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: () => Get.to(const EditProfileScreen(),
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
            selectedIndex == 'My Posts'
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
            selectedIndex == 'My Posts'
                ? SizedBox(
                    height: Get.height * 0.15,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          listOfProfileSection.length,
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
                                                fontWeight: FontWeight.w800),
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
                      listOfProfileSection.length,
                      (index) => Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color:
                                  listOfProfileSection[index] == selectedIndex
                                      ? secondaryColor
                                      : btnColor,
                            ),
                            child: InkWell(
                              onTap: () => setState(() {
                                selectedIndex = listOfProfileSection[index];
                              }),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: CustomText(
                                  text: listOfProfileSection[index],
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
                child: selectedIndex == "My Posts"
                    ? const MyPostWidget()
                    : selectedIndex == "My Map"
                        ? const MyProfileMapWidget(
                            isTopSpots: false,
                          )
                        : selectedIndex == "Fish Unlocked"
                            ? const MyFishUnlockedWidget()
                            : selectedIndex == "My Future Fish"
                                ? const MyFutureFishWidget()
                                : const MyGearWidget()),
          ],
        ),
      ),
    );
  }
}

class MyGearWidget extends StatelessWidget {
  const MyGearWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 4 / 5),
      itemCount: gearData.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.67, color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "${gearData[index].fishImage}",
                  height: Get.width * 0.45,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "${gearData[index].fishName}",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyFishUnlockedWidget extends StatelessWidget {
  const MyFishUnlockedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: fishData.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 5 / 4),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.67, color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  fishData[index].fishImage ?? '',
                  height: Get.width * 0.25,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fishData[index].fishName ?? '',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyPostWidget extends StatelessWidget {
  const MyPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: myPostList.length,
      itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            myPostList[index].fishingImage ?? '',
            height: Get.width * 0.32,
            width: Get.width * 0.32,
            fit: BoxFit.cover,
          )),
    );
  }
}
