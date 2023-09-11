import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../CONTROLLERS/post_controller.dart';
import 'package:get/get.dart';

import '../../UTILS/app_color.dart';
class EmptyPostWidget extends StatelessWidget {
  EmptyPostWidget({super.key, required this.onClick});
  final VoidCallback onClick;
  final postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              "images/animation_fish.json",
              height: 150,
              width: 200,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
              onPressed: onClick,
              style: TextButton.styleFrom(
                  backgroundColor: fishColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 0)),
              child: const Text(
                " Reload ",
                style: TextStyle(color: btnColor),
              ))
        ],
      ),
    );
  }
}
