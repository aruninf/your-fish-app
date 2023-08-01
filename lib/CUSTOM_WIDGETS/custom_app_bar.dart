import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, this.heading, this.logoColor, this.textColor, this.isMenu});

  final String? heading;
  final bool? isMenu;
  final Color? logoColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: fishColor,
                ),
                onPressed: () => Get.back(),
              ),
              Image.asset(
                fishTextImage,
                height: 70,
                width: 120,
                color: logoColor ?? secondaryColor,
              ),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: (isMenu ?? false) ? fishColor : primaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: (heading ?? '').isNotEmpty ?  Get.height * 0.02 : 0,
          ),
          (heading ?? '').isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              heading ?? '',
              style: TextStyle(
                  color: textColor ?? secondaryColor,
                  fontFamily: "Rodetta",
                  fontSize: 20,
                  height: 1.5,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ): const SizedBox.shrink(),
        ],
      ),
    );
  }
}
