import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/setting_controller.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_search_field.dart';
import 'package:yourfish/USER_BLOGS/blog_detail_screen.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'article_detail_screen.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final controller = Get.find<SettingController>();

  callApi() async {
    var data = {
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
          () => controller.getBlogs(data),
    );
    Future.delayed(
      Duration.zero,
          () => controller.getArticles(data),
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
              textColor: secondaryColor,
            ),
            const SizedBox(height: 6,),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: fishColor,
                ),
                labelColor: primaryColor,
                unselectedLabelColor: Colors.white70,

                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700
                ),
                tabs:  [
                  SizedBox(
                    width: Get.width*0.45,
                    child: const Tab(
                      text: 'Articles',
                    ),
                  ),
                  SizedBox(
                    width: Get.width*0.45,
                    child: const Tab(
                      text: 'Blogs',
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: controller.articleData.length,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
                    itemBuilder: (context, index) => ListTile(
                      onTap: ()=> Get.to(()=> ArticlesDetailScreen(articleData: controller.articleData[index]),
                          transition: Transition.rightToLeft),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                       child: Image.network('${controller.articleData[index].image}',height: 55,width: 55,fit: BoxFit.cover,),
                      ),
                      title:  CustomText(
                        text: '${controller.articleData[index].title}',
                        color: secondaryColor,
                        sizeOfFont: 16,
                      ),
                      subtitle:  CustomText(
                        text: '${controller.articleData[index].article}',
                        color: btnColor,
                        maxLin: 3,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: controller.blogData.length,
                    physics: const BouncingScrollPhysics(),
                    padding:
                    const EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
                    itemBuilder: (context, index) => ListTile(
                      onTap: ()=> Get.to(()=> BlogDetailScreen(blogData: controller.blogData[index]),
                          transition: Transition.rightToLeft),
                      dense: true,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network('${controller.blogData[index].image}',height: 55,width: 55,fit: BoxFit.cover,),
                      ),
                      title:  CustomText(
                        text: controller.blogData[index].heading ??'',
                        color: secondaryColor,
                        sizeOfFont: 16,
                      ),
                      subtitle: CustomText(text: controller.blogData[index].description ?? '',color: btnColor,maxLin: 3,),

                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
