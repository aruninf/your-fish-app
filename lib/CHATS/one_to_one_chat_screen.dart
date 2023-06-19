import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/custom_text_style.dart';

class OneToOneChatScreen extends StatelessWidget {
  const OneToOneChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: secondaryColor,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  ClipOval(
                    child: Image.asset(
                      fishingImage,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Alex Brown',
                        color: Colors.white,
                        sizeOfFont: 16,
                        weight: FontWeight.w700,
                      ),
                      CustomText(
                        text: 'online',
                        color: Colors.green,
                        sizeOfFont: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                  reverse: true,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              itemCount: 10,
              itemBuilder: (context, index) {
                return  Container(
                  width: Get.width*0.8,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.78, color: Colors.white),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(0),
                      )
                  ),
                  child: const CustomText(
                    text: 'Hello, How are you? Could you help me? Could you help me? Could you help me?',
                    color: Colors.white,
                    sizeOfFont: 12,
                  ),
                );
              },
            )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: SizedBox(
                height: 20,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      backgroundColor: fishColor,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "Send",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.white),
            ),
            hintText: "Type a message...",
            hintStyle: const TextStyle(color: Colors.white54),
            labelStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
