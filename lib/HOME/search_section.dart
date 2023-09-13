import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/HOME/search/get_all_post.dart';
import 'package:yourfish/HOME/search/friends_request.dart';
import 'package:yourfish/HOME/search/get_all_users.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late String? selectedIndex = "Posts";

  final listOfFilter = [
    "Posts",
    "Find a buddy",
    "Friend Requests",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    listOfFilter.length,
                    (index) => Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 8, right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: index == 2
                                ? fishColor
                                : listOfFilter[index] == selectedIndex
                                    ? secondaryColor
                                    : btnColor,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => setState(() {
                              selectedIndex = listOfFilter[index];
                              if (selectedIndex == 'Friend Requests') {
                                Get.to(FriendRequestScreen());
                              }
                            }),
                            child: index == 2
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text: listOfFilter[index],
                                          weight: FontWeight.w800,
                                          sizeOfFont: 13,
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: secondaryColor,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: CustomText(
                                      text: listOfFilter[index],
                                      weight: FontWeight.w800,
                                      sizeOfFont: 13,
                                    ),
                                  ),
                          ),
                        )),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child:
                selectedIndex == 'Posts' ? const AllPostWidget() : GetAllUserWidget(),
          ),
        ],
      ),
    );
  }
}
