import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/CREATE_POST/find_a_buddy_post_screen.dart';
import 'package:yourfish/MODELS/chat_user_response.dart';
import 'package:yourfish/MODELS/login_response.dart';
import 'package:yourfish/MODELS/post_response.dart';
import 'package:yourfish/UTILS/permission_services.dart';

import '../CHATS/chat_model.dart';
import '../CHATS/single_chat_page.dart';
import '../CREATE_POST/add_fish_screen.dart';
import '../MODELS/comment_response.dart';
import '../NETWORKS/network.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/app_color.dart';
import '../UTILS/consts.dart';
import '../UTILS/dialog_helper.dart';

class PostController extends GetxController {
  final isLocationOn = false.obs;
  final selectedCategories = [].obs;
  final isLoading = false.obs;
  final postData = <PostData>[].obs;
  final chatsUser = <ChatUserData>[].obs;
  final myPostData = <PostData>[].obs;
  final comments = <Comments>[].obs;
  final userData = LoginData().obs;
  final currentAddress = ''.obs;
  final addressPinCode = ''.obs;

  final comment = TextEditingController().obs;
  final currentPosition = Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.timestamp(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0)
      .obs;
  final selectedIndex = "My Posts".obs;
  final listOfProfileSection = [
    "My Posts",
    "My Map",
    "Fish Unlocked",
    "My Future Fish",
    "My Gear"
  ];

  @override
  void onReady() async {
    await getUserData();
    await getCurrentPosition();
    super.onReady();
  }

  ///🧨🧨🧨🧨🧨🧨 Get Post data and Search post 🧨🧨🧨🧨🧨

  Future<void> getPosts(dynamic data) async {
    if (data['page'] == 1) {
      postData.clear();
    }
    final response = await Network()
        .postRequest(endPoint: getPostsApi, formData: data, isLoader: false);
    if (response?.data != null) {
      PostResponse post = PostResponse.fromJson(response?.data);
      postData.addAll(post.data ?? []);
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Get Chat user 🧨🧨🧨🧨🧨

  Future<void> getChatsUser(dynamic data) async {
    //isLoading.value = true;
    final response =
        await Network().postRequest(endPoint: getChatUserApi, formData: data);
    if (response?.data != null) {
      //isLoading.value = false;
      final post = ChatUserResponse.fromJson(response?.data);
      chatsUser.value = post.data ?? [];
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Delete Chat user 🧨🧨🧨🧨🧨

  Future<void> deleteChat(String matchId) async {
    final data = {"match_id": matchId};
    final response = await Network().postRequest(
        endPoint: deleteChatUserApi, formData: data, isLoader: false);
    if (response?.data != null) {
      Get.closeAllSnackbars();
      final data = {
        "sortBy": "desc",
        "sortOn": "created_at",
        "page": 1,
        "limit": 20
      };
      getChatsUser(data);
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Report Post 🧨🧨🧨🧨🧨

  Future<void> reportPost(dynamic data) async {
    final response = await Network()
        .postRequest(endPoint: reportPostApi, formData: data, isLoader: true);
    if (response?.data != null) {
      Get.snackbar(response?.data['message'], '',
          colorText: Colors.green, snackPosition: SnackPosition.TOP);
      Get.closeAllSnackbars();
      final data = {
        "sortBy": "desc",
        "sortOn": "created_at",
        "page": 1,
        "limit": 20
      };
      getPosts(data);
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Comment on Post 🧨🧨🧨🧨🧨

  Future<void> addCommentOnPost(dynamic param) async {
    final response = await Network()
        .postRequest(endPoint: addCommentApi, formData: param, isLoader: false);
    if (response?.data != null) {
      Get.snackbar(response?.data['message'], '',
          colorText: Colors.green, snackPosition: SnackPosition.TOP);
      Get.closeAllSnackbars();
      final data = {"post_id": param['post_id'], "page": 1, "limit": 20};
      getPostComment(data);
    }
  }

  ///🧨🧨🧨🧨🧨🧨 Update Chat user 🧨🧨🧨🧨🧨

  Future<void> updateChat(dynamic data) async {
    await Network()
        .postRequest(endPoint: updateChatApi, formData: data, isLoader: false);
  }

  ///🧨🧨🧨🧨🧨🧨 Get user profile 🧨🧨🧨🧨🧨

  Future<void> getUserData() async {
    final response = await Network().getRequest(endPoint: getUserDataApi);
    if (response?.data != null) {
      LoginResponse user = LoginResponse.fromJson(response?.data);
      userData.value = user.data ?? LoginData();
    }
  }

  /// 💥💥💥💥💥💥💥 get My Post 💥💥💥💥💥💥

  Future<void> getMyPost(dynamic data) async {
    isLoading.value = true;
    final response = await Network().getRequest(endPoint: getMyPostApi);
    if (response?.data != null) {
      isLoading.value = false;
      PostResponse post = PostResponse.fromJson(response?.data);
      myPostData.value = post.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 get My Post Comment 💥💥💥💥💥💥

  Future<void> getPostComment(dynamic data) async {
    isLoading.value = true;
    final response = await Network()
        .postRequest(endPoint: getCommentApi, formData: data, isLoader: false);
    if (response?.data != null) {
      isLoading.value = false;
      var comm = CommentResponse.fromJson(response?.data);
      comments.value = comm.data ?? [];
    }
  }

  /// 💥💥💥💥💥💥💥 Update User Profile 💥💥💥💥💥💥💥

  Future<void> updateProfile(dynamic data) async {
    final response = await Network().postRequest(
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
    final response = await Network().postRequest(
        endPoint: data['id'] == null ? addPostApi : updatePostApi,
        formData: data,
        isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.find<UserController>().selectedFishTag.clear();
        Get.back();
        Get.snackbar(response?.data['message'], '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
        final data = {
          "sortBy": "desc",
          "sortOn": "created_at",
          "page": 1,
          "limit": 20
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
    final response = await Network()
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
      await Geolocator.requestPermission();
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

        //openAppSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          'Location permissions are permanently denied, we cannot request permissions.',
          '',
          colorText: Colors.deepOrangeAccent,
          snackPosition: SnackPosition.TOP);
      //openAppSettings();
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
    ///print("User Location 💥💥💥💥💥💥💥 ${position.latitude},${position.longitude}");
    await placemarkFromCoordinates(
            currentPosition.value.latitude, currentPosition.value.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress.value =
          '${place.subLocality}, ${place.subAdministrativeArea}';
      addressPinCode.value = place.postalCode ?? "";
    }).catchError((e) {
      debugPrint(e);
    });
  }

  addLiked(PostData postModel,bool status) {

    final data = {
      "request_type": "like",
      "post_id": postModel.id,
      "request_status": status
    };
    saveLikeFavourite(data);
  }

  saveLikeFavourite(dynamic data) async {
    final response = await Network().postRequest(
        endPoint: likesFavouritesApi, formData: data, isLoader: true);
    if (response?.data != null) {
      if (response?.data['status_code'] == 200) {
        Get.closeAllSnackbars();
        Get.snackbar(response?.data['message'], '',
            colorText: Colors.green, snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorDialog(
            title: "Error", description: response?.data['message']);
      }
    }
  }

  openChat(String receiverId) async {
    final data = {
      "receiver_id": receiverId,
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

  sharePost(PostData postModel) async {
    await Share.share(
        "${postModel.userName} shared a post just have a look \n${postModel.image}\n\n${postModel.caption}");
  }

  addFavourite(PostData postModel,bool status) {
    final data = {
      "request_type": "favourite",
      "post_id": postModel.id,
      "request_status": status
    };
    saveLikeFavourite(data);
  }

  openComment(BuildContext context, String s) {
    showModalBottomSheet(
        context: context,
        backgroundColor: primaryColor,
        builder: (builder) {
          return SafeArea(
              child: Container(
            padding:
                const EdgeInsets.only(top: 4, right: 16, left: 16, bottom: 16),
            height: Get.height * 0.55,
            width: Get.width,
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    const Text(
                      "Comments",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: secondaryColor, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.close,
                          color: secondaryColor,
                        ))
                  ],
                ),
                Obx(() => SizedBox(
                      height: Get.height * 0.36,
                      width: Get.width,
                      child: comments.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              itemCount: comments.length,
                              itemBuilder: (context, index) => ListTile(
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  title: Text(
                                    "${comments[index].username}",
                                    style: const TextStyle(
                                        color: fishColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "${comments[index].comment}",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                  trailing: Text(
                                    Consts.formatDateTimeToMMM(
                                        "${comments[index].createdAt}"),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )),
                            )
                          : const Center(
                              child: Text(
                                "No Comments",
                                style: TextStyle(color: secondaryColor),
                              ),
                            ),
                    )),
                SafeArea(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextFormField(
                      controller: comment.value,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: SizedBox(
                            height: 20,
                            child: TextButton(
                              onPressed: () {
                                if (comment.value.text.isNotEmpty) {
                                  var data = {
                                    "post_id": s,
                                    "comment": comment.value.text
                                  };
                                  addCommentOnPost(data);
                                  comment.value.text = "";
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: fishColor,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "Type a comment...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        });
  }

  showPopupMenuForEditPost(
      BuildContext context, TapDownDetails details, PostData? post, int index,int type) {
    showMenu<String>(
      context: context,
      color: fishColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(
            value: '1',
            height: 30,
            onTap: () {
              Get.dialog(
                Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 8, left: 16, right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Delete Post',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Are you sure want to delete post?',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (Get.isDialogOpen!) Get.back();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                var data = {"id": post?.id};
                                deletePost(data);

                                if (Get.isDialogOpen!) {
                                  Get.back();
                                }
                                myPostData.removeAt(index);
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            padding: const EdgeInsets.only(left: 13),
            child: const Text(
              'Delete Post',
              style: TextStyle(color: secondaryColor),
            )),
        PopupMenuItem<String>(
            value: '2',
            height: 30,
            onTap: () =>  Get.to( type!=1 ? AddFishScreen(postData: post,) : FindABuddyPostScreen(postData: post,)),
            padding: const EdgeInsets.only(left: 13),
            child: const Text(
              'Edit Post',
              style: TextStyle(color: secondaryColor),
            )),
      ],
      elevation: 8.0,
    );
  }
}
