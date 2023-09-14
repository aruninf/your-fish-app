import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CHATS/chat_model.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';

import '../CHATS/single_chat_page.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/consts.dart';

class ChatsSection extends StatefulWidget {
  const ChatsSection({super.key});

  @override
  State<ChatsSection> createState() => _ChatsSectionState();
}

class _ChatsSectionState extends State<ChatsSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final controller = Get.find<PostController>();

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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Text(
                'Chat',
                style: TextStyle(
                    color: secondaryColor,
                    fontFamily: "Rodetta",
                    fontSize: 20,
                    height: 1.5,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: CustomSearchField(hintText: 'Search'),
            ),
            Expanded(
              child: Obx(() => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.chatsUser.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.chatsUser.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 12, right: 12),
                          itemBuilder: (context, index) => ListTile(
                            onTap: () => controller.openChat(
                                "${controller.chatsUser[index].receiverId}"),
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 1),
                            leading: ClipOval(
                              child: Image.asset(
                                chatsList1[index].profileImage ?? '',
                                height: 45,
                                width: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: CustomText(
                              text: controller.chatsUser[index].receiverName ??
                                  '',
                              color: btnColor,
                              sizeOfFont: 14,
                              weight: FontWeight.w700,
                            ),
                            subtitle: CustomText(
                              text:
                                  controller.chatsUser[index].lastMessage ?? '',
                              color: Colors.white70,
                              sizeOfFont: 13,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: Consts.formatDateTimeToHHMM(controller
                                              .chatsUser[index].updatedAt ??
                                          "")
                                      .toLowerCase(),
                                  color: Colors.white54,
                                  sizeOfFont: 11,
                                ),
                                GestureDetector(
                                    onTapDown: (de) {
                                      showPopupMenu(context, de,
                                          controller.chatsUser[index].matchId);
                                    },
                                    child: Icon(
                                      Icons.more_horiz_rounded,
                                      color: secondaryColor.withOpacity(0.6),
                                      size: 16,
                                    ))
                              ],
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "No record found!",
                            style: TextStyle(color: secondaryColor),
                          ),
                        )),
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     const SizedBox(height: 6,),
      //     Container(
      //       height: 40,
      //       decoration: BoxDecoration(
      //         color: Colors.white38,
      //         borderRadius: BorderRadius.circular(
      //           25.0,
      //         ),
      //       ),
      //       child: TabBar(
      //         controller: _tabController,
      //         indicator: BoxDecoration(
      //           borderRadius: BorderRadius.circular(
      //             25.0,
      //           ),
      //           color: fishColor,
      //         ),
      //         labelColor: primaryColor,
      //         unselectedLabelColor: Colors.white70,
      //
      //         isScrollable: true,
      //         indicatorSize: TabBarIndicatorSize.label,
      //         indicatorPadding: EdgeInsets.zero,
      //         labelPadding: EdgeInsets.zero,
      //         indicatorColor: Colors.transparent,
      //         dividerColor: Colors.transparent,
      //         labelStyle: const TextStyle(
      //           fontWeight: FontWeight.w700
      //         ),
      //         tabs:  [
      //           SizedBox(
      //             width: Get.width*0.45,
      //             child: const Tab(
      //               text: 'Chats',
      //             ),
      //           ),
      //           SizedBox(
      //             width: Get.width*0.45,
      //             child: const Tab(
      //               text: 'Friend Request',
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //
      //     Expanded(
      //       child: TabBarView(
      //         controller: _tabController,
      //         children: [
      //           ListView.builder(
      //             itemCount: chatsList.length,
      //             physics: const BouncingScrollPhysics(),
      //             padding: const EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
      //             itemBuilder: (context, index) => ListTile(
      //               onTap: ()=> Get.to(()=>const OneToOneChatScreen(),
      //                   transition: Transition.rightToLeft),
      //               dense: true,
      //               contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      //               leading: ClipOval(
      //                child: Image.asset('${chatsList[index].profileImage}',height: 48,width: 48,fit: BoxFit.cover,),
      //               ),
      //               title:  CustomText(
      //                 text: '${chatsList[index].name}',
      //                 color: Colors.white,
      //               ),
      //               subtitle:  CustomText(
      //                 text: '${chatsList[index].username}',
      //                 color: Colors.white,
      //               ),
      //               trailing: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   SizedBox(
      //                     height: 30,
      //                     child: TextButton(
      //                         onPressed: () {},
      //                         style: TextButton.styleFrom(
      //                             backgroundColor: fishColor,
      //                             padding: EdgeInsets.zero,
      //                             shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(8))),
      //                         child: const Text(
      //                           'Follow',
      //                           style: TextStyle(
      //                               fontSize: 12,
      //                               color: primaryColor,
      //                               fontWeight: FontWeight.w700),
      //                         )),
      //                   ),
      //                   const SizedBox(
      //                     width: 8,
      //                   ),
      //                   SizedBox(
      //                     height: 30,
      //                     child: TextButton(
      //                         onPressed: () {},
      //                         style: TextButton.styleFrom(
      //                             padding: EdgeInsets.zero,
      //                             shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(8),
      //                                 side: const BorderSide(
      //                                     width: 1, color: Colors.white))),
      //                         child: const Text(
      //                           'Chat',
      //                           style: TextStyle(
      //                               fontSize: 12,
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.w600),
      //                         )),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           ListView.builder(
      //             itemCount: chatsList.length,
      //             physics: const BouncingScrollPhysics(),
      //             padding:
      //             const EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
      //             itemBuilder: (context, index) => ListTile(
      //
      //               dense: true,
      //               contentPadding:
      //               const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      //               leading: ClipOval(
      //                 child: Image.asset(chatsList[index].profileImage ??'',height: 48,width: 48,fit: BoxFit.cover,),
      //               ),
      //               title:  CustomText(
      //                 text: chatsList[index].name ??'',
      //                 color: Colors.white,
      //               ),
      //               //subtitle: const CustomText(text: '@a.brown',color: Colors.white,),
      //               trailing: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   SizedBox(
      //                     height: 30,
      //                     child: TextButton(
      //                         onPressed: () {},
      //                         style: TextButton.styleFrom(
      //                             backgroundColor: fishColor,
      //                             padding: EdgeInsets.zero,
      //                             shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(8))),
      //                         child: const Text(
      //                           'Accept',
      //                           style: TextStyle(
      //                               fontSize: 12,
      //                               color: primaryColor,
      //                               fontWeight: FontWeight.w700),
      //                         )),
      //                   ),
      //                   const SizedBox(
      //                     width: 8,
      //                   ),
      //                   SizedBox(
      //                     height: 30,
      //                     child: TextButton(
      //                         onPressed: () {},
      //                         style: TextButton.styleFrom(
      //                             padding: EdgeInsets.zero,
      //                             shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(8),
      //                                 side: const BorderSide(
      //                                     width: 1, color: Colors.white))),
      //                         child: const Text(
      //                           'Deny',
      //                           style: TextStyle(
      //                               fontSize: 12,
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.w600),
      //                         )),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //
      //   ],
      // ),
    );
  }

  showPopupMenu(BuildContext context, TapDownDetails details, String? matchId) {
    showMenu<String>(
      context: context,
      color: fishColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(
            value: '1',
            height: 30,
            onTap: () => controller.deleteChat(matchId ?? ""),
            padding: const EdgeInsets.only(left: 13),
            child: const Text(
              'Delete Chat',
              style: TextStyle(color: secondaryColor),
            )),
      ],
      elevation: 8.0,
    );
  }
}
