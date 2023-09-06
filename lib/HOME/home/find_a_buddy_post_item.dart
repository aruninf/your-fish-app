import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white70, width: .67)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'images/chat_image2.png',
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "@Allie-W",
                style: TextStyle(
                    fontFamily: "Rodetta",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: secondaryColor),
              ),
              const Spacer(),
              SizedBox(
                height: 30,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(width: 1, color: fishColor))),
                  child: const Text(
                    "CHAT",
                    style: TextStyle(
                        fontFamily: "Rodetta",
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomText(
            text:
            "Looking for a fishing buddy this weekend\nMessage e to plan!",
            weight: FontWeight.w600,
            sizeOfFont: 12,
            maxLin: 2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
