import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_search_field.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/consts.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import 'one_to_one_chat_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: "Chats",
              textColor: secondaryColor,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: CustomSearchField(hintText: 'Search'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatsList.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 12, right: 12),
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Get.to(() => const OneToOneChatScreen(),
                      transition: Transition.rightToLeft),
                  dense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  leading: ClipOval(
                    child: Image.asset(
                      chatsList[index].profileImage ?? '',
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: CustomText(
                    text: chatsList[index].name ?? '',
                    color: Colors.white,
                  ),
                  subtitle: CustomText(
                    text: chatsList[index].username ?? '',
                    color: Colors.white,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "18:56",
                        color: Colors.white54,
                        sizeOfFont: 11,
                      ),
                      GestureDetector(
                          onTapDown: (de) {
                            showPopupMenu(context, de);
                          },
                          child: Icon(
                            Icons.more_horiz_rounded,
                            color: secondaryColor.withOpacity(0.6),
                            size: 16,
                          ))
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

  showPopupMenu(BuildContext context, TapDownDetails details) {
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
        const PopupMenuItem<String>(
            value: '1',
            child: Text(
              'Delete',
              style: TextStyle(color: secondaryColor),
            )),
      ],
      elevation: 8.0,
    );
  }
}
