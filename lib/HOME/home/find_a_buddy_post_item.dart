import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MODELS/post_response.dart';
import '../../UTILS/app_color.dart';

class FindABuddyPostItem extends StatelessWidget {
  FindABuddyPostItem({super.key, required this.postModel});

  final controller = Get.find<PostController>();

  final PostData postModel;

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
              ClipOval(
                child: Image.network(
                  postModel.image ?? '',
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    fishPlaceHolder,
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                postModel.userHandle ?? '',
                style: const TextStyle(
                    fontFamily: "Rodetta",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: secondaryColor),
              ),
              const Spacer(),
              SizedBox(
                height: 30,
                child: TextButton(
                  onPressed: () => controller.openChat("${postModel.userId}"),
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
          CustomText(
            text: postModel.caption ?? '',
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
