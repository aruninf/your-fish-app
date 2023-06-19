import 'package:flutter/material.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:get/get.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import 'one_to_one_chat_screen.dart';

class ChatsScreen extends StatelessWidget{
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   title: const Text(
      //     'Chats',style: TextStyle(
      //       fontSize: 16,fontFamily: 'Rodetta',
      //       color: secondaryColor
      //   ),
      //   ),
      //
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      // ),
      body:  SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: "Chats",
              textColor: secondaryColor,
            ),
            Expanded(
              child: ListView.builder(
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
                  trailing: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: "12:00 pm",color: Colors.white54,),
                      Icon(Icons.more_horiz_rounded,color: Colors.white30,)
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