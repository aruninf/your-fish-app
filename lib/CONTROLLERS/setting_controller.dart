import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yourfish/MODELS/article_response.dart';
import 'package:yourfish/MODELS/blog_response.dart';
import 'package:yourfish/MODELS/faq_response.dart';
import 'package:yourfish/MODELS/post_response.dart';
import 'package:yourfish/NETWORKS/network_strings.dart';

import '../MODELS/content_response.dart';
import '../MODELS/setting_response.dart';
import '../NETWORKS/network.dart';
import '../UTILS/dialog_helper.dart';

class SettingController extends GetxController {
  final selectedCategories = [].obs;
  final listOfSettings = [
    //"Saved Posts",
    "Notifications",
    "Invite Friends",
    "Terms & Conditions",
    "Privacy Policy",
    "FAQ's",
    "Contact Us"
  ];

  final listOfOn = <String>[].obs;
  final listOfNotification = [
    "New Message",
    "New Fish Unlocked",
    "100 Bites",
    "Comment",
    "New Location",
    "New Follower",
    "New Share on Post"
  ].obs;
  final listOfOpen = [].obs;
  final isLoading = false.obs;
  final blogData = <BlogData>[].obs;
  final articleData = <ArticleData>[].obs;
  final faqData = <FaqData>[].obs;
  final savedPost = <PostData>[].obs;
  final contentData = <ContentData>[].obs;
  final currentValues = 50.0.obs;
  final settings = Settings().obs;

  /// 💥💥💥💥💥💥💥 Get Saved Post 💥💥💥💥💥💥💥

  Future<void> getSavedPost(dynamic data) async {
    isLoading.value = true;
    final response = await Network().getRequest(endPoint: getSavedPostApi);
    if (response?.data != null) {
      isLoading.value = false;
      final savedPostR = PostResponse.fromJson(response?.data);
      savedPost.value = savedPostR.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Blogs 💥💥💥💥💥💥💥

  Future<void> getBlogs(dynamic data) async {
    isLoading.value = true;
    final response =
        await Network().postRequest(endPoint: getBlogApi, formData: data);
    if (response?.data != null) {
      isLoading.value = false;
      BlogResponse blog = BlogResponse.fromJson(response?.data);
      blogData.value = blog.data ?? [];
    }
  }

  shareApp() async {
    Platform.isIOS
        ? Share.share('Download the Your Fish App and enjoy ultimate fishing /n https://apps.apple.com/us/app/your-fish/id6468571957',
            subject: 'Your Fish - Your Ultimate Fishing Companion')
        : Share.share('Download the Your Fish App and enjoy ultimate fishing /n https://play.google.com/store/apps/details?id=com.yourfish',
            subject: 'Your Fish - Your Ultimate Fishing Companion');
  }

  /// 💥💥💥💥💥💥💥 Get Articles 💥💥💥💥💥💥💥

  Future<void> getArticles(dynamic data) async {
    isLoading.value = true;
    final response =
        await Network().postRequest(endPoint: getArticlesApi, formData: data);
    if (response?.data != null) {
      isLoading.value = false;
      ArticleResponse blog = ArticleResponse.fromJson(response?.data);
      articleData.value = blog.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Faq 💥💥💥💥💥💥💥

  Future<void> getFaq(dynamic data) async {
    isLoading.value = true;
    final response =
        await Network().postRequest(endPoint: getFaqApi, formData: data);
    if (response?.data != null) {
      isLoading.value = false;
      FaqResponse blog = FaqResponse.fromJson(response?.data);
      faqData.value = blog.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Static content 💥💥💥💥💥💥💥

  getContent() async {
    isLoading.value = true;
    final response = await Network().getRequest(endPoint: getContentApi);
    if (response?.data != null) {
      isLoading.value = false;
      ContentResponse content = ContentResponse.fromJson(response?.data);
      contentData.value = content.data ?? [];
    }
  }

  Future<void> sendMessageToAdmin(dynamic data) async {
    final response = await Network()
        .postRequest(endPoint: contactUsApi, formData: data, isLoader: true);
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

  updatePublicFeedRadios(dynamic data) async {
    final response = await Network()
        .postRequest(endPoint: settingApi, formData: data, isLoader: false);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.closeAllSnackbars();
        Get.snackbar('Update Successfully', '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  getSettingData() async {
    listOfOn.clear();
    final response = await Network().getRequest(endPoint: getSettingDataApi);
    if (response?.data != null) {
      final settingResponse = SettingResponse.fromJson(response?.data);

      settings.value = settingResponse.data ?? Settings();

      currentValues.value = double.parse(settings.value.publicFeed ?? '0');
      if ((settings.value.newMessage ?? 0) == 1) {
        listOfOn.add(listOfNotification[0]);
      }
      if ((settings.value.newFishUnlocked ?? 0) == 1) {
        listOfOn.add(listOfNotification[1]);
      }
      if ((settings.value.bites100 ?? 0) == 1) {
        listOfOn.add(listOfNotification[2]);
      }
      if ((settings.value.comment ?? 0) == 1) {
        listOfOn.add(listOfNotification[3]);
      }
      if ((settings.value.newLocation ?? 0) == 1) {
        listOfOn.add(listOfNotification[4]);
      }
      if ((settings.value.newFollower ?? 0) == 1) {
        listOfOn.add(listOfNotification[5]);
      }
      if ((settings.value.newShareOnPost ?? 0) == 1) {
        listOfOn.add(listOfNotification[6]);
      }
    }
  }
}
