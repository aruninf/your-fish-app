import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/CONTROLLERS/setting_controller.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/CREATE_POST/find_a_buddy_post_screen.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:yourfish/HOME/chats_section.dart';
import 'package:yourfish/HOME/home_section.dart';
import 'package:yourfish/HOME/profile_section.dart';
import 'package:yourfish/HOME/search_section.dart';
import 'package:yourfish/PROFILE/settings_screen.dart';
import 'package:yourfish/UTILS/app_color.dart';

import '../CHATS/chats_screen.dart';
import '../CREATE_POST/add_fish_screen.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../PROFILE/my_map_screen.dart';
import '../USER_BLOGS/blog_screen.dart';
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
  var sController = Get.put(SettingController());
  var postController = Get.put(PostController());

  void _onItemTapped(int index) async {
    if(index != 2){
      setState(() {
        _page = index;
      });
    }

    var data = {
      "sortBy": "desc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "5"
    };
    if (index == 2) {
      modalBottomSheetMenu();
      Get.find<UserController>().getFish(data);
    } else if (index == 3) {
      postController.getPosts(data);
    } else {
      index == 0
          ? postController.getPosts(data)
          : index == 1
              ? postController.getChatsUser(data)
              : index == 4
                  ? getMyPost()
                  : nothing();
    }
  }

  void getMyPost() {
    var data = {
      "sortBy": "desc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "5"
    };
    Future.delayed(
      Duration.zero,
      () => postController.getMyPost(data),
    );
    postController.getUserData();
  }

  @override
  void initState() {
    var data = {
      "sortBy": "desc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "5"
    };
    Future.delayed(
      Duration.zero,
      () async {
        postController.getPosts(data);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      endDrawer: Drawer(
        elevation: 3.0,
        width: Get.width,
        child: RightDrawerMenuWidget(
          onClick: (index1) {
            if (index1 == 0) {
              setState(() {
                _page = 0;
              });
            } else if (index1 == 1) {
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
        title: Image.asset(
          fishTextImage,
          height: 60,
          width: 100,
          color: secondaryColor,
        ),

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
            HomeSection(),
            const ChatsSection(),
            const SizedBox(),
            const SearchSection(),
            ProfileSection(),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(top: 30),
      //   child: FloatingActionButton(
      //     onPressed: () => Get.to(() => const AddFishScreen(),
      //         transition: Transition.rightToLeft),
      //     tooltip: 'Add Fish Button',
      //     elevation: 0,
      //     backgroundColor: fishColor,
      //     shape: const CircleBorder(),
      //     child: const Icon(
      //       Icons.add,
      //       color: secondaryColor,
      //       size: 30,
      //     ),
      //   ),
      // ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomAppBar(
              padding: EdgeInsets.zero,
              color: fishColor,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Image.asset(
                        fishImage,
                        height: 40,
                        width: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _onItemTapped(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(
                        PhosphorIcons.chats,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _onItemTapped(1);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Image.asset(
                        'images/add_post.png',
                        height: 40,
                        width: 40,
                        color: secondaryColor,
                      ),
                      onPressed: () {
                        _onItemTapped(2);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Image.asset(
                        'images/search_icon.png',
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _onItemTapped(3);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Image.asset(
                        'images/user_icon.png',
                        height: 28,
                        width: 28,
                        color: Colors.white,
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

  nothing() {}

  void modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        backgroundColor: primaryColor,
        builder: (builder) {
          return SafeArea(
              child: Container(
            padding: const EdgeInsets.only(top:4,right: 16,left: 16,bottom: 16),
            height: Get.height * 0.2,
            width: Get.width,
            color: Colors.transparent,
            //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [

                Align(
                  alignment: Alignment.topRight,
                    child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close,color: secondaryColor,))
                ),
                SizedBox(
                  width: Get.width,
                  child: CommonButton(
                    btnBgColor: secondaryColor,
                    btnText: "Find a buddy",
                    btnTextColor: primaryColor,
                    onClick: () {
                       Get.to(() => FindABuddyPostScreen(), transition: Transition.rightToLeft);
                    },
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: CommonButton(
                    btnBgColor: secondaryColor,
                    btnText: "Upload a Post",
                    btnTextColor: primaryColor,
                    onClick: () {
                       Get.to(() => AddFishScreen(), transition: Transition.rightToLeft);
                    },
                  ),
                )
              ],
            ),
          ));
        });
  }
}

class RightDrawerMenuWidget extends StatelessWidget {
  RightDrawerMenuWidget({super.key, required this.onClick});

  final Function(int index1) onClick;

  final listOfItems = [
    "Home",
    "My Profile",
    "Top Spots",
    "Blog",
    "Chat",
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
                        Get.to(MyProfileMapWidget(isTopSpots: true),
                            transition: Transition.leftToRight);
                      } else if (index1 == 0) {
                        onClick(0);
                      } else if (index1 == 1) {
                        onClick(1);
                      } else if (index1 == 3) {
                        Get.to(BlogsScreen(),
                            transition: Transition.leftToRight);
                      } else if (index1 == 4) {
                        Get.to(const ChatsScreen(),
                            transition: Transition.leftToRight);
                      } else if (index1 == 5) {
                        Get.to(SettingsScreen(),
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
              height: Get.width * 0.55,
              width: Get.width * 0.70,
              fit: BoxFit.fill,
              color: Colors.white30,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.009,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  fishSignImage,
                  height: Get.width * 0.65,
                  width: Get.width * 0.6,
                  color: fishColor,
                ),
                //Spacer(),
                Image.asset(
                  fishTextImage,
                  height: Get.width * 0.3,
                  width: Get.width * 0.35,
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
