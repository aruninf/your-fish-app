import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/cached_image_view.dart';
import 'package:yourfish/MODELS/fish_response.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/image_place_holder_widget.dart';
import '../UTILS/app_color.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key, required this.fishData});

  final FishData fishData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0,
        centerTitle: true,
        title: Image.asset(
          fishTextImage,
          height: 70,
          width: 120,
          color: secondaryColor,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: fishColor,
          ),
        ),
      ),
      body: SizedBox(
        height: Get.height * 0.8,
        width: Get.width,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 0.78, color: Colors.white),
              borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${fishData.localName}, ${fishData.scientificName}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            fishData.categoryName ?? '',
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CustomCachedImage(
                         imageUrl: fishData.fishImage ?? '',
                          height: Get.height * 0.12,
                          width: Get.width * 0.45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  fishData.info ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: Colors.white, height: 1.5, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
