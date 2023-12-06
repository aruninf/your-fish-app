import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/setting_controller.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/CUSTOM_WIDGETS/cached_image_view.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_search_field.dart';
import 'package:yourfish/USER_BLOGS/blog_detail_screen.dart';
import 'package:yourfish/USER_BLOGS/view_all_blog_article.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../HOME/home/empty_post_widget.dart';
import '../UTILS/app_color.dart';
import 'article_detail_screen.dart';

class BlogsScreen extends StatefulWidget {
  BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  final controller = Get.find<SettingController>();

  final controllerR = Get.find<UserController>();
  var searchController = TextEditingController();

  callApi() async {
    var data = {"sortBy": "asc", "sortOn": "created_at", "page": 1, "limit": 4};
    var data1 = {
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": 1,
      "limit": 20
    };
    Future.delayed(
      Duration.zero,
      () => controllerR.getFish(data),
    );
    Future.delayed(
      Duration.zero,
      () => controller.getArticles(data1),
    );
  }

  @override
  Widget build(BuildContext context) {
    callApi();
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: "Fish Blog",
              textColor: secondaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: CustomSearchField(
                hintText: 'Search',
                controller: searchController,
                onChanges: (p0) {
                  var data = {
                    "sortBy": "desc",
                    "sortOn": "created_at",
                    "page": 1,
                    "limit": 8,
                    "filter": p0
                  };
                  controllerR.getFish(data);
                  searchController.text = "";
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Top Fish",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Rodetta',
                              color: btnColor),
                        ),
                        Spacer(),
                      ],
                    ),
                    Obx(() => controllerR.fishData.isNotEmpty
                        ? Wrap(
                            children: List.generate(
                              controllerR.fishData.length,
                              (index) => InkWell(
                                onTap: () => Get.to(
                                    () => BlogDetailScreen(
                                          fishData: controllerR.fishData[index],
                                        ),
                                    transition: Transition.rightToLeft),
                                child: Container(
                                  width: Get.width * 0.43,
                                  margin: EdgeInsets.only(
                                    left: index % 2 == 0 ? 0 : 8,
                                    right: index % 2 == 0 ? 8 : 0,
                                    bottom: index > 2 ? 0 : 8,
                                    top: index > 2 ? 8 : 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.67, color: Colors.white),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CustomCachedImage(
                                            imageUrl: controllerR
                                                    .fishData[index]
                                                    .fishImage ??
                                                '',
                                            height: Get.width * 0.33,
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          controllerR.fishData[index]
                                                  .scientificName ??
                                              '',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : EmptyPostWidget(
                            onClick: () async {
                              var data = {
                                "sortBy": "desc",
                                "sortOn": "created_at",
                                "page": 1,
                                "limit": 4,
                              };
                              await controllerR.getFish(data);
                            },
                          )),
                    Row(
                      children: [
                        const Text(
                          "Articles",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Rodetta',
                              color: btnColor),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () =>
                                Get.to(() => const ViewAllScreen()),
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                      ],
                    ),
                    Obx(() => Wrap(
                          children: List.generate(
                              controller.articleData.length,
                              (index) => InkWell(
                                    onTap: () => Get.to(
                                        () => ArticlesDetailScreen(
                                              articleData:
                                                  controller.articleData[index],
                                            ),
                                        transition: Transition.rightToLeft),
                                    child: Container(
                                      width: Get.width,
                                      margin: const EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          //color: btnColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: btnColor, width: 0.78)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: CustomText(
                                          text: controller
                                                  .articleData[index].title ??
                                              '',
                                          sizeOfFont: 16,
                                          color: btnColor,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  )),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
