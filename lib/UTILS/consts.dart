import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:yourfish/UTILS/app_color.dart';

/// Static Data

class ChatModel {
  String? name;
  String? username;
  String? profileImage;

  ChatModel({this.name, this.username, this.profileImage});
}

List<ChatModel> chatsList = [
  ChatModel(
      name: 'Alex Brown',
      username: '@a.brown',
      profileImage: 'images/chat_image3.png'),
  ChatModel(
      name: 'Allie Williams',
      username: '@a.williams',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: '@s.will',
      profileImage: 'images/chat_image1.png'),
  ChatModel(
      name: 'CiLiza',
      username: '@c.liza',
      profileImage: 'images/fishing_image.jpeg'),
  ChatModel(
      name: 'Allie Williams',
      username: '@a.williams',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: '@s.will',
      profileImage: 'images/chat_image1.png'),
  ChatModel(
      name: 'Alex Brown',
      username: '@a.brown',
      profileImage: 'images/chat_image3.png'),
  ChatModel(
      name: 'Allie Williams',
      username: '@a.williams',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: '@s.will',
      profileImage: 'images/chat_image1.png'),
  ChatModel(
      name: 'Alex Brown',
      username: '@a.brown',
      profileImage: 'images/chat_image3.png'),
  ChatModel(
      name: 'Allie Williams',
      username: '@a.williams',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: '@s.will',
      profileImage: 'images/chat_image1.png'),
];

List<ChatModel> chatsList1 = [
  ChatModel(
      name: 'Alex Brown',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image3.png'),
  ChatModel(
      name: 'Allie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image1.png'),
  ChatModel(
      name: 'CiLiza',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/fishing_image.jpeg'),
  ChatModel(
      name: 'Allie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image1.png'),
  ChatModel(
      name: 'Alex Brown',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image3.png'),
  ChatModel(
      name: 'Allie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image1.png'),
  ChatModel(
      name: 'Alex Brown',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image3.png'),
  ChatModel(
      name: 'Allie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image2.png'),
  ChatModel(
      name: 'Shopie Williams',
      username: 'Hi,i am interested on ...',
      profileImage: 'images/chat_image1.png'),
];

class FishModel {
  String? fishName;
  String? fishImage;

  FishModel({this.fishName, this.fishImage});
}

List<FishModel> gearData = [
  FishModel(fishImage: 'images/fishing_rod.png', fishName: 'Fishing Rod'),
  FishModel(fishImage: 'images/fishing_lure.png', fishName: 'Fishing Lure'),
  FishModel(fishImage: 'images/my_post_image1.png', fishName: 'Fishing Tool'),
  FishModel(fishImage: 'images/fishing_rod.png', fishName: 'Fishing Rod'),
  FishModel(fishImage: 'images/fishing_lure.png', fishName: 'Fishing Lure'),
  FishModel(fishImage: 'images/my_post_image1.png', fishName: 'Fishing Tool'),
  FishModel(fishImage: 'images/fishing_rod.png', fishName: 'Fishing Rod'),
  FishModel(fishImage: 'images/fishing_lure.png', fishName: 'Fishing Lure'),
  FishModel(fishImage: 'images/my_post_image1.png', fishName: 'Fishing Tool'),
];

List<FishModel> fishBlogData = [
  FishModel(fishImage: 'images/redfish.png', fishName: 'Alfonsino'),
  FishModel(fishImage: 'images/bieye_tuna.png', fishName: 'Bieye Tuna'),
  FishModel(fishImage: 'images/broadbill.png', fishName: 'Broadbill swordfish'),
  FishModel(fishImage: 'images/gummy_shark.png', fishName: 'Gummy shark'),
];

List<FishModel> fishData = [
  FishModel(fishImage: 'images/redfish.png', fishName: 'Alfonsino'),
  FishModel(fishImage: 'images/bieye_tuna.png', fishName: 'Bieye Tuna'),
  FishModel(fishImage: 'images/broadbill.png', fishName: 'Broadbill swordfish'),
  FishModel(fishImage: 'images/gummy_shark.png', fishName: 'Gummy shark'),
  FishModel(fishImage: 'images/red_fish.png', fishName: 'Redfish'),
  FishModel(
      fishImage: 'images/southern_fish.png', fishName: 'Southern bluefin tuna'),
];

class PostModel {
  String? userName;
  String? fishingImage;

  PostModel({this.userName, this.fishingImage});
}

List<PostModel> postList = [
  PostModel(userName: '@yourfish', fishingImage: 'images/post_image.png'),
  PostModel(userName: '@yourfish', fishingImage: 'images/post_image.png'),
  PostModel(userName: '@c.liza', fishingImage: 'images/fishing_image.jpeg'),
  PostModel(userName: '@brown', fishingImage: 'images/post_image.png'),
  PostModel(userName: '@c.liza', fishingImage: 'images/fishing_image.jpeg'),
];

List<PostModel> myPostList = [
  PostModel(userName: '@brown', fishingImage: 'images/my_post_image1.png'),
  PostModel(userName: '@alex', fishingImage: 'images/my_post_image2.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/my_post_image3.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/my_post_image4.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/post_image1.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/my_post_image5.png'),
  PostModel(userName: '@brown', fishingImage: 'images/my_post_image1.png'),
  PostModel(userName: '@alex', fishingImage: 'images/my_post_image2.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/my_post_image3.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/my_post_image4.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/post_image1.png'),
  PostModel(userName: '@shopie', fishingImage: 'images/my_post_image5.png'),
];

class Consts {
  /// Image Picker ///
  static Future<File?> imageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 600,
        maxWidth: 800,
        imageQuality: 25);
    if (pickedFile != null) {
      return cropFile(pickedFile);
    }
    return null;
  }

  static Future<File?> imageFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 600,
        maxWidth: 800,
        imageQuality: 25);
    if (pickedFile != null) {
      return cropFile(pickedFile);
    }
    return null;
  }

  static Future<File?> cropFile(XFile? file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 70,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Image Cropper',

        ),
      ],
    );

    return File(croppedFile!.path);
  }

  /// Date Formats //////////////////////////////////////
  static String parseTimeStamp(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value).toLocal();
    var d12 = DateFormat('hh:mm').format(date);
    return d12;
  }

  static String parseTimeHH(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value).toLocal();
    var d12 = DateFormat('HH:mm').format(date);
    return d12;
  }

  static String parseTimeStamp1(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value).toLocal();
    var d12 = DateFormat('hh:mm a, MMM dd').format(date);
    return d12;
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }
}
