import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/UTILS/app_images.dart';
import 'package:yourfish/UTILS/consts.dart';

import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});


  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).requestFocus(FocusNode());
    return Scaffold(
      backgroundColor: primaryColor,
      extendBody: true,
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: CustomSearchField(
              hintText: 'Search',
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: postList.length,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              itemBuilder: (context, index) => index == 0
                  ? const NotificationItem()
                  : SingleFishPostWidget(postModel: postList[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white70, width: .67)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'images/chat_image2.png',
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "@Allie-W",
                style: TextStyle(
                    fontFamily: "Rodetta",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: secondaryColor),
              ),
              const Spacer(),
              SizedBox(
                height: 30,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(width: 1, color: fishColor))),
                  child: const Text(
                    "CHAT",
                    style: TextStyle(
                        fontFamily: "Rodetta",
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomText(
            text:
                "Looking for a fishing buddy this weekend\nMessage e to plan!",
            weight: FontWeight.w600,
            sizeOfFont: 12,
            maxLin: 2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class SingleFishPostWidget extends StatelessWidget {
  const SingleFishPostWidget({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(
                "${postModel.userName}",
                style: const TextStyle(
                    fontFamily: "Rodetta",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: secondaryColor),
              ),
              const Spacer(),
              TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(alignment: Alignment.topRight),
                  icon: const Icon(
                    PhosphorIcons.map_pin,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: const CustomText(
                    text: "Cape Grafton",
                    weight: FontWeight.w400,
                    sizeOfFont: 13,
                    color: Colors.white,
                  ))
            ],
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "${postModel.fishingImage}",
                width: double.infinity,
                height: Get.height * 0.4,
                fit: BoxFit.cover,
              )),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    fishIcon,
                    height: 28,
                    width: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.chat,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
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
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.bookmark_simple,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const CustomText(
            text:
                "Lorem ipsum dolor sit amet, connect dolor sit amet, consectetur maisena adipiscing elit, sed do eiusmod",
            weight: FontWeight.w600,
            sizeOfFont: 14,
            maxLin: 2,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomText(
            text: "Mary Williams Love that 🙌🏼 !!",
            weight: FontWeight.w500,
            sizeOfFont: 13,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
