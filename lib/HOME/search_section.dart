import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/HOME/profile_section.dart';

import '../CHATS/one_to_one_chat_screen.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/consts.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late String? selectedIndex = "Posts";

  final listOfBeach = [
    "Mermaid Beach",
    "Palm Beach",
    "Bondi Beach",
    "Manly Beach,",
    "Lizard Island"
  ];

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
            child: SizedBox(
              height: Get.height * 0.055,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    listOfFilter.length,
                    (index) => Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: index == 2
                                ? fishColor
                                : listOfFilter[index] == selectedIndex
                                    ? secondaryColor
                                    : btnColor,
                          ),
                          child: InkWell(
                            onTap: () => setState(() {
                              selectedIndex = listOfFilter[index];
                              if (selectedIndex == 'Friend Requests') {
                                Get.to(const FriendRequestScreen());
                              }
                            }),
                            child: index == 2
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
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
                                        horizontal: 16, vertical: 8),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: CustomSearchField(
              hintText: 'Search Fish',
            ),
          ),
          selectedIndex == 'Posts'
              ? const SizedBox(
                  width: 5,
                )
              : const SizedBox(
                  width: 16,
                ),
          selectedIndex == 'Posts'
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: Get.height * 0.055,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          listOfBeach.length,
                          (index) => Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: listOfBeach[index] == selectedIndex
                                      ? secondaryColor
                                      : btnColor,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print("==============$index");
                                    setState(() {
                                      selectedIndex = listOfBeach[index];
                                    });
                                    print("==============$selectedIndex");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: CustomText(
                                      text: listOfBeach[index],
                                      weight: FontWeight.w700,
                                      sizeOfFont: 13,
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: btnColor,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Fishing Type',
                                weight: FontWeight.w800,
                                sizeOfFont: 13,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: primaryColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: btnColor,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Location',
                                weight: FontWeight.w800,
                                sizeOfFont: 13,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: primaryColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          Expanded(
            child: selectedIndex == 'Posts'
                ? const MyPostWidget()
                : ListView.builder(
                    itemCount: chatsList.length,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 8, left: 8, right: 8),
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => Get.to(() => const OneToOneChatScreen(),
                          transition: Transition.rightToLeft),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1),
                      leading: ClipOval(
                        child: Image.asset(
                          '${chatsList[index].profileImage}',
                          height: 48,
                          width: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: CustomText(
                        text: '${chatsList[index].name}',
                        color: Colors.white,
                      ),
                      subtitle: CustomText(
                        text: '${chatsList[index].username}',
                        color: Colors.white,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30,
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: fishColor,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                child: const Text(
                                  'Follow',
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
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                            width: 1, color: Colors.white))),
                                child: const Text(
                                  'Chat',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class FriendRequestScreen extends StatelessWidget {
  const FriendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: chatsList.length,
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  leading: ClipOval(
                    child: Image.asset(
                      chatsList[index].profileImage ?? '',
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: CustomText(
                    text: chatsList[index].name ?? '',
                    color: Colors.white,
                  ),
                  //subtitle: const CustomText(text: '@a.brown',color: Colors.white,),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: fishColor,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
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
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        width: 1, color: Colors.white))),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
