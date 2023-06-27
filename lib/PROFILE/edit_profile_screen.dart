import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_search_field.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLocationOn = false;
  var selectedCategories = [];
  late List<String> listOfCategory = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   titleSpacing: 0,
      //   title: const Text(
      //     'Edit Profile',style: TextStyle(
      //     fontSize: 16,fontFamily: 'Rodetta',
      //     color: secondaryColor
      //   ),
      //   ),
      //   leading: IconButton(
      //     onPressed: ()=> Get.back(),
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //   ),
      // ),
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
                child: Column(
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
                            Image.asset(
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
                    Wrap(
                      children: List.generate(
                          listOfCategory.length,
                          (index) => Container(
                                margin: const EdgeInsets.only(top: 8, left: 5),
                                decoration: BoxDecoration(
                                  color: selectedCategories
                                          .contains(listOfCategory[index])
                                      ? secondaryColor
                                      : btnColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedCategories
                                          .contains(listOfCategory[index])) {
                                        selectedCategories
                                            .remove(listOfCategory[index]);
                                      } else {
                                        selectedCategories
                                            .add(listOfCategory[index]);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 12),
                                    child: CustomText(
                                      text: listOfCategory[index],
                                      sizeOfFont: 16,
                                      weight: FontWeight.w700,
                                      color: selectedCategories
                                              .contains(listOfCategory[index])
                                          ? fishColor
                                          : primaryColor,
                                    ),
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
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
          onClick: () => Get.back(),
        ),
      ),
    );
  }
}
