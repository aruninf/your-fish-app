import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/cached_image_view.dart';
import 'package:yourfish/MODELS/article_response.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../UTILS/app_color.dart';

class ArticlesDetailScreen extends StatelessWidget {
  const ArticlesDetailScreen({super.key, required this.articleData});

  final ArticleData articleData;

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
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomCachedImage(
                  imageUrl: articleData.title ?? '',
                  height: Get.height * 0.25,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                dense: false,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  articleData.title ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: secondaryColor,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      PhosphorIcons.share_network,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                articleData.article ?? '',
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    color: Colors.white, height: 1.5, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
