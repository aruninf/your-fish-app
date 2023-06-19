import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import '../CHATS/one_to_one_chat_screen.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class ChatsSection extends StatefulWidget {
  const ChatsSection({super.key});

  @override
  State<ChatsSection> createState() => _ChatsSectionState();
}

class _ChatsSectionState extends State<ChatsSection> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      extendBody: false,
      body: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: fishColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,

              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabs:  [
                SizedBox(
                  width: Get.width*0.45,
                  child: const Tab(
                    text: 'Chats',
                  ),
                ),
                SizedBox(
                  width: Get.width*0.45,
                  child: const Tab(
                    text: 'Friend Request',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: 16,
                  physics: const BouncingScrollPhysics(),
                  padding:
                  const EdgeInsets.only(top: 8,bottom: 8),
                  itemBuilder: (context, index) => ListTile(
                    onTap: ()=> Get.to(()=>const OneToOneChatScreen(),
                        transition: Transition.rightToLeft),
                    dense: true,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white30,
                      maxRadius: 25,
                      child: CustomText(
                        text: 'Photo',
                        sizeOfFont: 11,
                        color: Colors.white30,
                      ),
                    ),
                    title: const CustomText(
                      text: 'Alex Brown',
                      color: Colors.white,
                    ),
                    subtitle: const CustomText(
                      text: '@a.brown',
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
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                'Follow',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600),
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
                ListView.builder(
                  itemCount: 16,
                  physics: const BouncingScrollPhysics(),
                  padding:
                  const EdgeInsets.only(top: 8,bottom: 8),
                  itemBuilder: (context, index) => ListTile(

                    dense: true,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white30,
                      maxRadius: 25,
                      child: CustomText(
                        text: 'Photo',
                        sizeOfFont: 11,
                        color: Colors.white30,
                      ),
                    ),
                    title: const CustomText(
                      text: 'Alex Brown',
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
                                    fontWeight: FontWeight.w600),
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

              ],
            ),
          ),

        ],
      ),
    );
  }
}
