import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fish_you_experience.dart';
import 'package:yourfish/HOME/main_home.dart';
import 'package:yourfish/MODELS/fish_category_response.dart';
import 'package:yourfish/MODELS/fish_response.dart';
import 'package:yourfish/MODELS/user_response.dart';
import 'package:yourfish/UTILS/dialog_helper.dart';

import '../CHATS/chat_model.dart';
import '../CHATS/single_chat_page.dart';
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

class UserController extends GetxController {
  final selectedCategories = [].obs;
  final selectedCategory= 0.obs;
  final selectedFishInterest = [].obs;
  final selectedFishingLocation = [].obs;
  final selectedFishExp = [].obs;
  final selectedFishTag = <FishData>[].obs;
  final allUsers = <UserData>[].obs;
  final friendRequest = <UserData>[].obs;
  final selectedFishGear = [].obs;
  final isDataLoading = false.obs;
  final isPasswordVisible = true.obs;
  final selectDob = ''.obs;
  String? gender;
  DateTime selectedDate = DateTime.now();
  final fishData = <FishData>[].obs;
  final fishUnlockData = <FishData>[].obs;
  final futureFishData = <FishData>[].obs;
  final fishingLocation = <FishingLocationData>[].obs;
  final fishCategory = <Category>[].obs;
  final fishingGear = <GearData>[].obs;

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
    final response = await Network()
        .postRequest(endPoint: loginApi, formData: data, isLoader: true);
    if (response?.data != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(response?.data);
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
    final response = await Network()
        .postRequest(endPoint: registerApi, formData: data, isLoader: true);
    if (response?.data != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(response?.data);
      if (loginResponse.status ?? false) {
        Utility.setStringValue(tokenKey, loginResponse.token ?? "");
        Get.offAll(() => SelectFishInterest(),
            transition: Transition.rightToLeft);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish 💥💥💥💥💥💥💥

  Future<void> getFish(dynamic data) async {
    isDataLoading.value = true;
    if(data['page']==1){
      fishData.clear();
    }
    final response =
        await Network().postRequest(endPoint: getFishApi, formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      FishResponse fish = FishResponse.fromJson(response?.data);
      fishData.addAll(fish.data ?? []);
    }
  }



  /// 💥💥💥💥💥💥💥 Get Future Fish 💥💥💥💥💥💥💥

  Future<void> getFutureFish(dynamic data) async {
    isDataLoading.value = true;
    if(data['page']==1){
      futureFishData.clear();
    }
    final response =
    await Network().getRequest(endPoint: getMyFutureFishApi);
    if (response?.data != null) {
      isDataLoading.value = false;
      FishResponse fish = FishResponse.fromJson(response?.data);
      futureFishData.addAll(fish.data ?? []);
    }
  }


  /// 💥💥💥💥💥💥💥 Get Unlock Fish 💥💥💥💥💥💥💥

  Future<void> getUnlockFish(dynamic data) async {
    isDataLoading.value = true;
    if(data['page']==1){
      fishUnlockData.clear();
    }
    final response =
    await Network().getRequest(endPoint: getUnlockFishApi);
    if (response?.data != null) {
      isDataLoading.value = false;
      FishResponse fish = FishResponse.fromJson(response?.data);
      fishUnlockData.addAll(fish.data ?? []);
    }
  }

  /// 💥💥💥💥💥💥💥 Get All user 💥💥💥💥💥💥💥

  Future<void> getAllUsers(dynamic data) async {
    isDataLoading.value = true;
    if(data['page']==1){
      allUsers.clear();
    }
    final response =
        await Network().postRequest(endPoint: getAllUserApi, formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      final sp = UserResponse.fromJson(response?.data);
      allUsers.addAll(sp.data ?? []);
    }
  }

  /// 💥💥💥💥💥💥💥 Get Friend Request 💥💥💥💥💥💥💥

  Future<void> getFriendRequest(dynamic data) async {
    isDataLoading.value = true;
    if(data['page']==1){
      friendRequest.clear();
    }
    final response = await Network().postRequest(
        endPoint: getFriendRequestsListApi, formData: data, isLoader: false);
    if (response?.data != null) {
      isDataLoading.value = false;
      final sp = UserResponse.fromJson(response?.data);
      friendRequest.addAll(sp.data ?? []);
    }
  }

  /// 💥💥💥💥💥💥💥 User Follow, Unfollow  and Friend Request Api (Accept,deny,) 💥💥💥💥💥💥💥

  Future<void> sendRequest(dynamic data, int type) async {
    //isDataLoading.value = true;

    final response = await Network()
        .postRequest(endPoint: sendRequestApi, formData: data,isLoader: true);
    if (response?.data != null) {
      Get.closeAllSnackbars();
      Get.snackbar(response?.data['message'], '',
          colorText: Colors.green, snackPosition: SnackPosition.TOP);
      if (type == 1) {
        getAllUsers(
            {"sortBy": "desc", "sortOn": "id", "page": 1, "limit": "20"});
      } else {
        getFriendRequest(
            {"sortBy": "desc", "sortOn": "id", "page": 1, "limit": "20"});
        getAllUsers(
            {"sortBy": "desc", "sortOn": "id", "page": 1, "limit": "20"});
      }
    }
  }

  openChat(UserData userData) async {
    final data = {
      "receiver_id": userData.id,
    };
    final response = await Network()
        .postRequest(endPoint: startChatApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.to(
            () => SingleChatPage(
                  receiver: ReceiverModel(
                      matchRoomId: "${response?.data['data']['match_id']}",
                      receiverId: "${response?.data['data']['receiver_id']}"),
                  image: "${response?.data['data']['receiver_image']}",
                  matchName: "${response?.data['data']['receiver_name']}",
                ),
            transition: Transition.rightToLeft);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Location 💥💥💥💥💥💥💥

  Future<void> getFishLocation(dynamic data) async {
    isDataLoading.value = true;
    final response = await Network()
        .postRequest(endPoint: getFishingLocationApi, formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      LocationResponse fish = LocationResponse.fromJson(response?.data);
      fishingLocation.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Gear 💥💥💥💥💥💥💥

  Future<void> getFishGear(dynamic data) async {
    isDataLoading.value = true;
    final response = await Network()
        .postRequest(endPoint: getFishingGearApi, formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      GearResponse fish = GearResponse.fromJson(response?.data);
      fishingGear.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Get Fish Category 💥💥💥💥💥💥💥

  Future<void> getFishCategory(dynamic data) async {
    isDataLoading.value = true;
    final response = await Network()
        .postRequest(endPoint: getFishCategoryApi, formData: data);
    if (response?.data != null) {
      isDataLoading.value = false;
      CategoryResponse fish = CategoryResponse.fromJson(response?.data);
      fishCategory.value = fish.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Update OnBoarding 💥💥💥💥💥💥💥

  Future<void> updateOnBoarding(dynamic data, int step) async {
    isDataLoading.value = false;
    final response = await Network().postRequest(
        endPoint: updateOnBoardingApi, formData: data, isLoader: true);
    if (response?.data != null) {
      //print("updateProfile=================${response?.data}");
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
    await Network().postRequest(endPoint: deleteAccountApi, formData: param);
  }

  ///🧨🧨🧨🧨🧨🧨 User Logout 🧨🧨🧨🧨🧨

  userLogout() async {
    await Network().postRequest(endPoint: logoutApi, formData: {});
  }
}
