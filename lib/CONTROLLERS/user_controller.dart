import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yourfish/HOME/main_home.dart';
import 'package:yourfish/MODELS/fish_category_response.dart';
import 'package:yourfish/MODELS/fish_response.dart';
import 'package:yourfish/UTILS/dialog_helper.dart';

import '../CREATE_ACCOUNT/select_fish_interest.dart';
import '../MODELS/login_response.dart';
import '../NETWORKS/network.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/utils.dart';



class UserController extends GetxController {
  var selectedCategories = [].obs;
  final listOfCategory = [
    "Spear1",
    "Line Fishing1",
    "Spear2",
    "Line Fishing2",
    "Spear3",
    "Line3",
    "Spear4",
    "Line Fishing3",
    "Spear5",
    "Line4",
    "Spear6",
    "Line Fishing4",
  ];
  var selectedIndex = "My Posts".obs;

  final listOfProfileSection = [
    "My Posts",
    "My Map",
    "Fish Unlocked",
    "My Future Fish",
    "My Gear"
  ];

  var uploadFile = File('').obs;
  var selectDob = ''.obs;
  final nameController = TextEditingController();
  final handleController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final numberController = TextEditingController();
  String? gender;
  DateTime selectedDate = DateTime.now();
  var fishData = <FishData>[].obs;
  var fishCategory = <Category>[].obs;

  @override
  void onReady() async {
    String? email = await Utility.getStringValue(emailKey);
    String? name = await Utility.getStringValue(nameKey);
    nameController.text = name ?? '';
    emailController.text = email ?? '';
    super.onReady();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2001),
        firstDate: DateTime(1960),
        lastDate: DateTime(2004));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      final DateFormat format = DateFormat('yyyy-MM-dd');
      final String formatted = format.format(selectedDate);
      selectDob.value = formatted;
    }
  }

  /// 🍔🍔🍔🍔🍔Login Function 🍔🍔🍔🍔🍔🍔
  Future<void> userLogin(dynamic data) async {
    var response = await Network()
        .postRequest(endPoint: loginApi, formData: data, isLoader: true);
    if (response?.data != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(response?.data);
      if (loginResponse.status ?? false) {
        Utility.setStringValue(tokenKey, loginResponse.token ?? "");
        Utility().saveBoolValue(isLoginKey, true);
        Get.offAll(() => const MainHome());
        Get.snackbar('Login Successfully', '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  ///🧨🧨🧨🧨🧨🧨 User Register 🧨🧨🧨🧨🧨

  Future<void> userRegister(dynamic data) async {
    var response = await Network()
        .postRequest(endPoint: registerApi, formData: data, isLoader: true);
    if (response?.data != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(response?.data);
      if (loginResponse.status ?? false) {
        Utility.setStringValue(tokenKey, loginResponse.token ?? "");
        Utility().saveBoolValue(isLoginKey, true);
        Get.to(() => SelectFishInterest(), transition: Transition.rightToLeft);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  ///🧨🧨🧨🧨🧨🧨 get user profile 🧨🧨🧨🧨🧨

  Future<void> getUserProfile() async {
    var response = await Network().getRequest(endPoint: getFishApi);
    if (response?.data != null) {
      FishResponse fish = FishResponse.fromJson(response?.data);
      fishData.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish 💥💥💥💥💥💥💥

  Future<void> getFish() async {
    var response = await Network().getRequest(endPoint: getFishApi);
    if (response?.data != null) {
      FishResponse fish = FishResponse.fromJson(response?.data);
      fishData.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Location 💥💥💥💥💥💥💥

  Future<void> getFishLocation() async {
    var response = await Network().getRequest(endPoint: getFishApi);
    if (response?.data != null) {
      FishResponse fish = FishResponse.fromJson(response?.data);
      fishData.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Gear 💥💥💥💥💥💥💥

  Future<void> getFishGear() async {
    var response = await Network().getRequest(endPoint: getFishApi);
    if (response?.data != null) {
      FishResponse fish = FishResponse.fromJson(response?.data);
      fishData.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Category 💥💥💥💥💥💥💥

  Future<void> getFishCategory() async {
    var response = await Network().getRequest(endPoint: getFishApi);
    if (response?.data != null) {
      CategoryResponse fish = CategoryResponse.fromJson(response?.data);
      fishCategory.value = fish.data ?? [];
    }
  }
  /// 💥💥💥💥💥💥💥 Update User Profile 💥💥💥💥💥💥💥

  Future<void> updateProfile(dynamic data) async {
    var response = await Network()
        .putRequest(endPoint: updateProfileApi, queryParameters: data);
    if (response?.data != null) {
      //print("updateProfile=================${response?.data}");
      //Utility.setStringValue(NetworkStrings.onBoard,"pref");
      //gets.Get.offAll(() =>SelectTopicsScreen());
    }
  }

  ///🧨🧨🧨🧨🧨🧨 User Delete Account 🧨🧨🧨🧨🧨

  deleteAccount(Map<String, String> param) async {
    await Network().postRequest(endPoint: logoutApi, formData: param);
  }

  ///🧨🧨🧨🧨🧨🧨 User Logout 🧨🧨🧨🧨🧨

  userLogout() async {
    await Network().postRequest(endPoint: logoutApi, formData: {});
  }
}
