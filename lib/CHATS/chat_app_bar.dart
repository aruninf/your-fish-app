import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/cached_image_view.dart';
import 'package:yourfish/UTILS/app_color.dart';

import '../CONTROLLERS/database.dart';
import '../CONTROLLERS/post_controller.dart';

class CustomChatAppBar extends StatelessWidget {
  const CustomChatAppBar({
    Key? key,
    required this.title,
    required this.image,
    required this.userId,
    required this.chatRoomId,
    required this.backPress,
  }) : super(key: key);

  final String title;
  final String image;
  final String userId;
  final String chatRoomId;
  final VoidCallback backPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            ClipOval(
              child: CustomCachedImage(
                imageUrl: image,
                fit: BoxFit.cover,
                height: 45,
                width: 45,
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    //isProfileVisible ? title : title[0],
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: Database().getStatus(userId),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Text(
                          "Offline",
                          style: TextStyle(fontSize: 13, color: Colors.white54),
                        );
                      } else {
                        var status = snapshot.data as DocumentSnapshot;
                        //print("==getStatus===========================${status['status']}");
                        return Text(
                          status['status'].toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: (status['status']
                                          .toString()
                                          .toLowerCase()
                                          .contains("online") ||
                                      status['status']
                                          .toString()
                                          .toLowerCase()
                                          .contains("typing"))
                                  ? Colors.green
                                  : Colors.white54),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                  onTapDown: (de) {
                    showPopupMenu(context, de, chatRoomId);
                  },
                  child: const Icon(
                    Icons.more_vert_rounded,
                    color: fishColor,
                    size: 24,
                  )),
            )
          ],
        ),
      ),
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
            onTap: () {
              Get.find<PostController>().deleteChat(matchId ?? "");
              Get.back();
            },
            padding: const EdgeInsets.only(left: 13),
            child: const Text(
              'Report and Block',
              style: TextStyle(color: secondaryColor),
            )),
      ],
      elevation: 8.0,
    );
  }
}
