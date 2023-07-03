import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_search_field.dart';
import 'package:yourfish/USER_BLOGS/blog_detail_screen.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/consts.dart';
import 'article_detail_screen.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   title:  const Text(
      //     "Fish Blog",style: TextStyle(
      //       fontSize: 16,fontFamily: 'Rodetta',
      //       color: secondaryColor
      //   ),),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: "Fish Blog",
              textColor: secondaryColor,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomSearchField(hintText: 'Search'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Top Fish",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Rodetta',
                              color: btnColor),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                      ],
                    ),
                    Wrap(
                      children: List.generate(
                        fishBlogData.length,
                        (index) => InkWell(
                          onTap: () => Get.to(() => const BlogDetailScreen(),
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
                              border:
                                  Border.all(width: 0.67, color: Colors.white),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      fishBlogData[index].fishImage ?? '',
                                      height: Get.width * 0.33,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    fishBlogData[index].fishName ?? '',
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
                    ),
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
                            onPressed: () {},
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                      ],
                    ),
                    Wrap(
                      children: List.generate(
                          10,
                          (index) => InkWell(
                                onTap: () => Get.to(
                                    () => const ArticlesDetailScreen(),
                                    transition: Transition.rightToLeft),
                                child: Container(
                                  width: Get.width,
                                  margin: const EdgeInsets.only(top: 12),
                                  decoration: BoxDecoration(
                                      //color: btnColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: btnColor, width: 0.78)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CustomText(
                                      text:
                                          'Top Spots on the Gold Coast this summer',
                                      sizeOfFont: 16,
                                      color: btnColor,
                                      weight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )),
                    )
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
