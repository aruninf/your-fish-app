import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'add_your_gear.dart';
import 'get_start.dart';

class SelectFishingCategory extends StatefulWidget {
  const SelectFishingCategory({super.key});

  @override
  State<SelectFishingCategory> createState() => _SelectFishingCategoryState();
}

class _SelectFishingCategoryState extends State<SelectFishingCategory> {
  Widget appBarTitle = const Text(
    "Search Category",
    style: TextStyle(color: Colors.white, fontSize: 12),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
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
  var selectedCategories = [];
  String _searchText = "";

  _searchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //init();
  }

  void _handleSearchStart() {
    setState(() {});
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon = const Icon(
        Icons.search,
        color: Colors.white,
      );
      appBarTitle = const Text(
        "Search Category",
        style: TextStyle(color: Colors.white, fontSize: 12),
      );
      _searchQuery.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   centerTitle: true,
      //   title: Image.asset(fishTextImage,height: 50,width: 100,color: secondaryColor,),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: 'Select you favourite \nFishing categories',
              textColor: fishColor,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search Category',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
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
                                  selectedCategories.add(listOfCategory[index]);
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              child: CustomText(
                                text: listOfCategory[index],
                                sizeOfFont: 16,
                                weight: FontWeight.bold,
                                color: selectedCategories
                                        .contains(listOfCategory[index])
                                    ? fishColor
                                    : primaryColor,
                              ),
                            ),
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () => Get.to(() => const AddYourGear(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
