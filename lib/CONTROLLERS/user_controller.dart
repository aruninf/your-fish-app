import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fish_you_experience.dart';
import 'package:yourfish/HOME/main_home.dart';
import 'package:yourfish/MODELS/fish_category_response.dart';
import 'package:yourfish/MODELS/fish_response.dart';
import 'package:yourfish/UTILS/dialog_helper.dart';

import '../CREATE_ACCOUNT/add_your_gear.dart';
import '../CREATE_ACCOUNT/select_fish_interest.dart';
import '../CREATE_ACCOUNT/select_fishing_category.dart';
import '../CREATE_ACCOUNT/select_fishing_location.dart';
import '../MODELS/fishing_location_response.dart';
import '../MODELS/gear_response.dart';
import '../MODELS/login_response.dart';
import '../NETWORKS/network.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/utils.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  var selectedCategories = [].obs;
  var selectedFishInterest = [].obs;
  var selectedFishingLocation = [].obs;
  var selectedFishExp = [].obs;
  var selectedFishGear = [].obs;
  var isDataLoading = false.obs;
  var isPasswordVisible = true.obs;

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
  var fishingLocation = <FishingLocationData>[].obs;
  var fishCategory = <Category>[].obs;
  var fishingGear = <GearData>[].obs;

  @override
  void onReady() async {
    String? email = await Utility.getStringValue(emailKey);
    String? name = await Utility.getStringValue(nameKey);
    nameController.text = name ?? '';
    emailController.text = email ?? '';
    super.onReady();
  }

  @override
  void dispose() {
    isDataLoading.value = false;
    nameController.dispose();
    handleController.dispose();
    emailController.dispose();
    dobController.dispose();
    numberController.dispose();
    super.dispose();
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
      UserResponse loginResponse = UserResponse.fromJson(response?.data);
      if (loginResponse.status ?? false) {
        Utility.setStringValue(tokenKey, loginResponse.token ?? "");
        if (loginResponse.data?.gearId != null) {
          Utility().saveBoolValue(isLoginKey, true);
          Get.offAll(() => const MainHome());
          Get.snackbar('Login Successfully', '',
              colorText: Colors.green, snackPosition: SnackPosition.TOP);
        } else {
          Get.off(() => SelectFishInterest(),
              transition: Transition.rightToLeft);
        }
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
      UserResponse loginResponse = UserResponse.fromJson(response?.data);
      if (loginResponse.status ?? false) {
        nameController.text='';
        handleController.text='';
        emailController.text='';
        selectDob.value='';
        numberController.text='';
        gender='Male';
        Utility.setStringValue(tokenKey, loginResponse.token ?? "");
        Get.offAll(() => SelectFishInterest(), transition: Transition.rightToLeft);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish 💥💥💥💥💥💥💥

  Future<void> getFish(dynamic data) async {
    isDataLoading.value = true;
    var response = await Network().postRequest(endPoint: getFishApi,formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      FishResponse fish = FishResponse.fromJson(response?.data);
      fishData.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Location 💥💥💥💥💥💥💥

  Future<void> getFishLocation(dynamic data) async {
    isDataLoading.value = true;
    var response = await Network().postRequest(endPoint: getFishingLocationApi,formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      LocationResponse fish = LocationResponse.fromJson(response?.data);
      fishingLocation.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Gear 💥💥💥💥💥💥💥

  Future<void> getFishGear(dynamic data) async {
    isDataLoading.value = true;
    var response = await Network().postRequest(endPoint: getFishingGearApi,formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      GearResponse fish = GearResponse.fromJson(response?.data);
      fishingGear.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Category 💥💥💥💥💥💥💥

  Future<void> getFishCategory(dynamic data) async {
    isDataLoading.value = true;
    var response = await Network().postRequest(endPoint: getFishCategoryApi,formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      CategoryResponse fish = CategoryResponse.fromJson(response?.data);
      fishCategory.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Update OnBoarding 💥💥💥💥💥💥💥

  Future<void> updateOnBoarding(dynamic data, int step) async {
    isDataLoading.value = false;
    var response = await Network().postRequest(
        endPoint: updateOnBoardingApi, formData: data, isLoader: true);
    if (response?.data != null) {
      print("updateProfile=================${response?.data}");
      if (step == 1) {
        Get.to(() => SelectFishYouExperience(),
            transition: Transition.rightToLeft);
      } else if (step == 2) {
        Get.to(() => SelectFishingLocation(),
            transition: Transition.rightToLeft);
      } else if (step == 3) {
        Get.to(() => SelectFishingCategory(),
            transition: Transition.rightToLeft);
      } else if (step == 4) {
        Get.to(() => AddYourGear(), transition: Transition.rightToLeft);
      } else {
        Utility().saveBoolValue(isLoginKey, true);
        Get.offAll(() => const MainHome());
        Get.snackbar('Registration Successfully', '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      }
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
