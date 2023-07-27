import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yourfish/MODELS/article_response.dart';
import 'package:yourfish/MODELS/blog_response.dart';
import 'package:yourfish/MODELS/faq_response.dart';
import 'package:yourfish/NETWORKS/network_strings.dart';

import '../MODELS/content_response.dart';
import '../NETWORKS/network.dart';
import '../PROFILE/faq_screen.dart';

class SettingController extends GetxController {
  var selectedCategories = [].obs;
  final listOfSettings = [
    "Notifications",
    "Invite Friends",
    "Terms & Conditions",
    "Privacy Policy",
    "FAQ's",
    "Contact Us"
  ];
  var listOfOpen = [].obs;
  var isLoading=false.obs;
  var blogData=<BlogData>[].obs;
  var articleData=<ArticleData>[].obs;
  var faqData=<FaqData>[].obs;
  var contentData=<ContentData>[].obs;
  var currentValues = 20.0.obs;



  /// 💥💥💥💥💥💥💥 Get Blogs 💥💥💥💥💥💥💥

  Future<void> getBlogs(dynamic data) async {
    isLoading.value=true;
    var response = await Network().getRequest(endPoint: getBlogApi);
    if (response?.data != null) {
      isLoading.value=false;
      BlogResponse blog = BlogResponse.fromJson(response?.data);
      blogData.value = blog.data ?? [];

    }
  }


  shareApp() async {
    Share.share('check out my App https://appifanydevelopers.github.io/#/', subject: 'Look what I made!');
  }


  /// 💥💥💥💥💥💥💥 Get Articles 💥💥💥💥💥💥💥

  Future<void> getArticles(dynamic data) async {
    isLoading.value=true;
    var response = await Network().getRequest(endPoint: getArticlesApi);
    if (response?.data != null) {
      isLoading.value=false;
      ArticleResponse blog = ArticleResponse.fromJson(response?.data);
      articleData.value = blog.data ?? [];

    }
  }

  /// 💥💥💥💥💥💥💥 Get Faq 💥💥💥💥💥💥💥

  Future<void> getFaq(dynamic data) async {
    isLoading.value=true;
    var response = await Network().postRequest(endPoint: getFaqApi,formData: data);
    if (response?.data != null) {
      isLoading.value=false;
      FaqResponse blog = FaqResponse.fromJson(response?.data);
      faqData.value = blog.data ?? [];

    }
  }

  getContent() async {
    isLoading.value=true;
    var response = await Network().getRequest(endPoint: getContentApi);
    if (response?.data != null) {
      isLoading.value=false;
      ContentResponse content = ContentResponse.fromJson(response?.data);
      contentData.value = content.data ?? [];
    }
  }

}
