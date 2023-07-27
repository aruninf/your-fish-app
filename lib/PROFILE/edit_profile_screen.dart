import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_search_field.dart';
import 'package:yourfish/MODELS/login_response.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key,required this.userData});
  final UserData userData;
  final controller = Get.put(PostController());
  final userController = Get.find<UserController>();

  final nameController = TextEditingController();
  final handleController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final numberController = TextEditingController();

  void getData()async {
    var data={
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(Duration.zero,() {
      nameController.text = userData.name ?? '';
      emailController.text = userData.email ?? '';
      handleController.text = userData.handle ?? '';
      numberController.text = userData.phoneNumber ?? '';
      locationController.text = userData.locationId ?? '';
      userController.getFishCategory(data);
    },);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    print("$userData=============${controller.userData.value.name ?? ''}");
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: 'Edit Profile',
              textColor: secondaryColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 1),
                      leading: ClipOval(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            (controller.userData.value.profilePic ?? '')
                                .isNotEmpty
                                ? Image.network(
                              controller.userData.value.profilePic ?? '',
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'images/chat_image2.png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                            )
                                : Image.asset(
                              'images/chat_image2.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),




                            const Text(
                              'Change\nPhoto',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white60),
                            )
                          ],
                        ),
                      ),
                      title: TextFormField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.55),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                            const BorderSide(color: Colors.white),
                          ),
                          hintText: "Alex Brown",
                          hintStyle: const TextStyle(color: Colors.white54),
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: locationController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.55),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "Gold Coast,au",
                        hintStyle: const TextStyle(color: Colors.white54),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: handleController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.55),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "FishingAlex-22",
                        hintStyle: const TextStyle(color: Colors.white54),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.55),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "alexbrown@ gmail.com",
                        hintStyle: const TextStyle(color: Colors.white54),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: numberController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 0.55),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "0123456789",
                        hintStyle: const TextStyle(color: Colors.white54),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rodetta',
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const CustomSearchField(hintText: 'Search'),
                    const SizedBox(
                      height: 8,
                    ),
                    userController.fishCategory.isNotEmpty ? Wrap(
                      children: List.generate(
                          userController.fishCategory.length,
                              (index) => Container(
                            margin:
                            const EdgeInsets.only(top: 8, left: 5),
                            decoration: BoxDecoration(
                              color: controller.selectedCategories
                                  .contains(userController.fishCategory[index].id)
                                  ? secondaryColor
                                  : btnColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (controller.selectedCategories
                                    .contains(userController.fishCategory[index].id)) {
                                  controller.selectedCategories.remove(
                                      userController.fishCategory[index].id);
                                } else {
                                  controller.selectedCategories.add(
                                      userController.fishCategory[index].id);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                child: CustomText(
                                  text:
                                  userController.fishCategory[index].name ?? '',
                                  sizeOfFont: 16,
                                  weight: FontWeight.w700,
                                  color: controller.selectedCategories
                                      .contains(userController.fishCategory[index].id)
                                      ? fishColor
                                      : primaryColor,
                                ),
                              ),
                            ),
                          )),
                    ): const SizedBox.shrink()
                  ],
                )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(16),
        child: CommonButton(
          btnBgColor: secondaryColor,
          btnTextColor: primaryColor,
          btnText: "Save",
          onClick: () {

            var data={};
            controller.updateProfile(data);
          },
        ),
      ),
    );
  }
}
