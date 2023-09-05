import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yourfish/MODELS/article_response.dart';
import 'package:yourfish/MODELS/blog_response.dart';
import 'package:yourfish/MODELS/faq_response.dart';
import 'package:yourfish/NETWORKS/network_strings.dart';

import '../MODELS/content_response.dart';
import '../MODELS/saved_post_response.dart';
import '../NETWORKS/network.dart';
import '../UTILS/dialog_helper.dart';

class SettingController extends GetxController {
  var selectedCategories = [].obs;
  final listOfSettings = [
    "Saved Posts",
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
  var savedPost=<SavedPost>[].obs;
  var contentData=<ContentData>[].obs;
  var currentValues = 68.0.obs;


  /// 💥💥💥💥💥💥💥 Get Saved Post 💥💥💥💥💥💥💥

  Future<void> getSavedPost(dynamic data) async {
    isLoading.value=true;
    var response = await Network().getRequest(endPoint: getSavedPostApi);
    if (response?.data != null) {
      isLoading.value=false;
      SavedPostResponse blog = SavedPostResponse.fromJson(response?.data);
      savedPost.value = blog.data ?? [];
    }
  }


  /// 💥💥💥💥💥💥💥 Get Blogs 💥💥💥💥💥💥💥

  Future<void> getBlogs(dynamic data) async {
    isLoading.value=true;
    var response = await Network().postRequest(endPoint: getBlogApi,formData: data);
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
    var response = await Network().postRequest(endPoint: getArticlesApi,formData: data);
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

  /// 💥💥💥💥💥💥💥 Get Static content 💥💥💥💥💥💥💥

  getContent() async {
    isLoading.value=true;
    var response = await Network().getRequest(endPoint: getContentApi);
    if (response?.data != null) {
      isLoading.value=false;
      ContentResponse content = ContentResponse.fromJson(response?.data);
      contentData.value = content.data ?? [];
    }
  }

  Future<void> sendMessageToAdmin(dynamic data) async {
    var response = await Network().postRequest(
        endPoint: contactUsApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.back();
        Get.snackbar('Request sent Successfully', '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  void updatePublicFeedRadios(dynamic data) async {
    var response = await Network().postRequest(endPoint: settingApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.back();
        Get.snackbar('Update Successfully', '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

}
