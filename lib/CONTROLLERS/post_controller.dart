import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yourfish/MODELS/login_response.dart';
import 'package:yourfish/MODELS/post_response.dart';
import 'package:yourfish/UTILS/permission_services.dart';

import '../NETWORKS/network.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/dialog_helper.dart';

class PostController extends GetxController {
  var isLocationOn = false.obs;
  var selectedCategories = [].obs;
  var isLoading = false.obs;
  var postData = <PostData>[].obs;
  var myPostData = <PostData>[].obs;
  var userData = UserData().obs;
  var currentAddress = ''.obs;
  var isLiked = false.obs;
  var isFav = false.obs;

  var currentPosition = Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.timestamp(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0)
      .obs;
  var selectedIndex = "My Posts".obs;
  final listOfProfileSection = [
    "My Posts",
    "My Map",
    "Fish Unlocked",
    "My Future Fish",
    "My Gear"
  ];

  @override
  void onReady() async {
    await getCurrentPosition();
    super.onReady();
  }

  ///🧨🧨🧨🧨🧨🧨 Get Post data 🧨🧨🧨🧨🧨

  Future<void> getPosts(dynamic data) async {
    isLoading.value = true;
    var response = await Network()
        .postRequest(endPoint: getPostsApi, formData: data, isLoader: false);
    if (response?.data != null) {
      isLoading.value = false;
      PostResponse post = PostResponse.fromJson(response?.data);
      postData.value = post.data ?? [];
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Get Chat user 🧨🧨🧨🧨🧨

  Future<void> getChatsUser(dynamic data) async {
    isLoading.value = true;
    var response =
        await Network().postRequest(endPoint: getFishApi, formData: data);
    if (response?.data != null) {
      isLoading.value = false;
      PostResponse post = PostResponse.fromJson(response?.data);
      postData.value = post.data ?? [];
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Get user profile 🧨🧨🧨🧨🧨

  Future<void> getUserData() async {
    var response = await Network().getRequest(endPoint: getUserDataApi);
    if (response?.data != null) {
      UserResponse user = UserResponse.fromJson(response?.data);
      userData.value = user.data ?? UserData();
    }
  }

  /// 💥💥💥💥💥💥💥 get My Post 💥💥💥💥💥💥

  Future<void> getMyPost(dynamic data) async {
    isLoading.value = true;
    var response = await Network().getRequest(endPoint: getMyPostApi);
    if (response?.data != null) {
      isLoading.value = false;
      PostResponse post = PostResponse.fromJson(response?.data);
      myPostData.value = post.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Update User Profile 💥💥💥💥💥💥💥

  Future<void> updateProfile(dynamic data) async {
    var response = await Network().postRequest(
        endPoint: updateProfileApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        getUserData();
        Get.back();
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Create New Post 🧨🧨🧨🧨🧨

  Future<void> createPost(dynamic data) async {
    var response = await Network()
        .postRequest(endPoint: addPostApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.back();
        Get.snackbar('Post created Successfully', '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
        var data = {
          "sortBy": "asc",
          "sortOn": "created_at",
          "page": "1",
          "limit": "20"
        };
        getPosts(data);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Create New Post 🧨🧨🧨🧨🧨

  Future<void> deletePost(dynamic data) async {
    var response = await Network()
        .postRequest(endPoint: deletePostApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.snackbar('Post deleted successfully', '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  ///💥💥💥💥💥💥💥 Location Permission 💥💥💥💥💥💥💥

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          'Location services are disabled. Please enable the services!', '',
          colorText: Colors.deepOrangeAccent, snackPosition: SnackPosition.TOP);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Location permissions are denied', '',
            colorText: Colors.deepOrangeAccent,
            snackPosition: SnackPosition.TOP);

        ///openAppSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          'Location permissions are permanently denied, we cannot request permissions.',
          '',
          colorText: Colors.deepOrangeAccent,
          snackPosition: SnackPosition.TOP);
      openAppSettings();
      return false;
    }
    return true;
  }

  ///💥💥💥💥💥💥💥  Current Location 💥💥💥💥💥💥💥

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    await PermissionService().askLocation();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition.value = position;
      getAddressFromLatLng(currentPosition.value);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  ///💥💥💥💥💥💥💥  Get Address from Lat Long 💥💥💥💥💥💥💥

  Future<void> getAddressFromLatLng(Position position) async {
    print(
        "User Location 💥💥💥💥💥💥💥 ${position.latitude},${position.longitude}");
    await placemarkFromCoordinates(
            currentPosition.value.latitude, currentPosition.value.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress.value =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
    }).catchError((e) {
      debugPrint(e);
    });
  }

  addLiked(PostData postModel) {
    isLiked.value=!isLiked.value;
    var data = {
      "request_type": "like",
      "post_id": postModel.id,
      "request_status": isLiked.value
    };
    saveLikeFavourite(data);
  }

  saveLikeFavourite(dynamic data) async {
    var response = await Network()
        .postRequest(endPoint: likesFavouritesApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.snackbar(response?.data['message'], '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  openChat(PostData postModel) async {
    var data={
      "receiver_id": postModel.userId,
      "post_id": postModel.id,
    };
    var response = await Network()
        .postRequest(endPoint: startChatApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.snackbar(response?.data['message'], '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  sharePost(PostData postModel) async {
    await Share.share(
        "${postModel.userName} shared a post just have a look \n${postModel.image}\n\n${postModel.caption}");
  }

  addFavourite(PostData postModel) {
    isFav.value=!isFav.value;
    var data = {
      "request_type": "favourite",
      "post_id": postModel.id,
      "request_status": isFav.value
    };
    saveLikeFavourite(data);
  }
}
