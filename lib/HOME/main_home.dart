import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:yourfish/HOME/chats_section.dart';
import 'package:yourfish/HOME/home_section.dart';
import 'package:yourfish/HOME/profile_section.dart';
import 'package:yourfish/HOME/search_section.dart';
import 'package:yourfish/PROFILE/settings_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';

import '../CHATS/chats_screen.dart';
import '../CREATE_POST/add_fish_screen.dart';
import '../USER_BLOGS/blog_screenn.dart';
import '../PROFILE/my_map_screen.dart';
import '../UTILS/app_images.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _page = 0;
  late List<String> address;

  void _onItemTapped(int index) async {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      endDrawer: Drawer(
        elevation: 3.0,
        child: RightDrawerMenuWidget(
          onClick: (index1) {
            print("========$index1");
            if (index1 == 0) {
              setState(() {
                _page = 0;
              });
            }else if (index1 == 1) {
              setState(() {
                _page = 4;
              });
            }
          },
          // onClick: (index1) {
          //   Get.back();
          //   if (index1 == 2) {
          //     Get.to(const MyProfileMapWidget(),
          //         transition: Transition.leftToRight);
          //   } else if (index1 == 0) {
          //     // setState(() {
          //     //   _page = 0;
          //     // });
          //   }else if (index1 == 1) {
          //     // setState(() {
          //     //   _page = 3;
          //     // });
          //   }else if (index1 == 3) {
          //     Get.to(const BlogsScreen(),
          //         transition: Transition.leftToRight);
          //   } else if (index1 == 4) {
          //     Get.to(const ChatsScreen(),
          //         transition: Transition.leftToRight);
          //   } else if (index1 == 5) {
          //     Get.to(const SettingsScreen(),
          //         transition: Transition.leftToRight);
          //   }
          // },
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(fishTextImage,height: 60,width: 100,color: secondaryColor,),

        // title: CustomText(
        //   text: _page == 0
        //       ? 'Your Fish'
        //       : _page == 1
        //           ? 'Chats'
        //           : _page == 3
        //               ? 'Search Fish'
        //               : 'Profile',
        //   color: Colors.white,
        //   sizeOfFont: 16,
        //   weight: FontWeight.w700,
        // ),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(
                PhosphorIcons.list_bold,
                color: fishColor,
                size: 35,
              ))
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _page,
          children: [
            const HomeSection(),
            const ChatsSection(),
            const SizedBox(),
            const SearchSection(),
            ProfileSection(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: FloatingActionButton(
          onPressed: () => Get.to(() => const AddFishScreen(),
              transition: Transition.rightToLeft),
          tooltip: 'Add Fish Button',
          elevation: 0,
          backgroundColor: fishColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: secondaryColor,
            size: 30,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomAppBar(
              padding: EdgeInsets.zero,
              color: fishColor,
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Image.asset(
                        fishImage,
                        height: 34,width: 34,
                        color: _page == 0 ? secondaryColor : Colors.white,
                      ),
                      onPressed: () {
                        _onItemTapped(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        PhosphorIcons.chats,
                        color: _page == 1 ? secondaryColor : Colors.white,
                      ),
                      onPressed: () {
                        _onItemTapped(1);
                      },
                    ),
                  ),
                  const Expanded(child: Text('')),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        PhosphorIcons.magnifying_glass,
                        color: _page == 3 ? secondaryColor : Colors.white,
                      ),
                      onPressed: () {
                        _onItemTapped(3);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        PhosphorIcons.user,
                        color: _page == 4 ? secondaryColor : Colors.white,
                      ),
                      onPressed: () {
                        _onItemTapped(4);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class RightDrawerMenuWidget extends StatelessWidget {
  RightDrawerMenuWidget({super.key,
  required this.onClick
  });

  final Function(int index1) onClick;

  final listOfItems = [
    "Home",
    "My Profile",
    "Top Spots",
    "Blogs",
    "Chats",
    "Settings"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: fishColor,
                    )),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: listOfItems.length,
                  itemBuilder: (context, index1) => ListTile(
                    //onTap: onClick(index),
                    onTap: () {
                      Get.back();
                      if (index1 == 2) {
                        Get.to(const MyProfileMapWidget(isTopSpots: true),
                            transition: Transition.leftToRight);
                      } else if (index1 == 0) {
                        onClick(0);
                      }else if (index1 == 1) {
                        onClick(1);
                      }else if (index1 == 3) {
                        Get.to(const BlogsScreen(),
                            transition: Transition.leftToRight);
                      } else if (index1 == 4) {
                        Get.to(const ChatsScreen(),
                            transition: Transition.leftToRight);
                      } else if (index1 == 5) {
                        Get.to(const SettingsScreen(),
                            transition: Transition.leftToRight);
                      }
                    },
                    dense: true,
                    title: CustomText(
                      text: listOfItems[index1],
                      weight: FontWeight.w800,
                      sizeOfFont: 22,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Positioned(
            top: Get.height * 0.10,
            right: 0,
            child: Image.asset(
              fishRightImage,
              height: Get.width * 0.5,
              width: Get.width * 0.5,
              fit: BoxFit.fill,
              color: Colors.white30,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.009,
            left: 0,
            child: Row(
              children: [
                Image.asset(
                  fishSignImage,
                  height: Get.width * 0.3,
                  width: Get.width * 0.45,
                  color: fishColor,
                ),
                Image.asset(
                  fishTextImage,
                  height: Get.width * 0.3,
                  width: Get.width * 0.3,
                  color: btnColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
