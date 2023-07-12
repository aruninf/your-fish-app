import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fishing_category.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_app_bar.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class SelectFishingLocation extends StatefulWidget {
  const SelectFishingLocation({super.key});

  @override
  State<SelectFishingLocation> createState() => _SelectFishingLocationState();
}

class _SelectFishingLocationState extends State<SelectFishingLocation> {
  Widget appBarTitle = const Text(
    "Search Fish",
    style: TextStyle(color: Colors.white, fontSize: 12),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  late List<String> _list;
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
        "Search Location",
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
              heading: 'Locations where you \nGo fishing',
              textColor: fishColor,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search Location',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => Container(
                  width: Get.width,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: CustomText(
                      text: 'Gold Coast, AU',
                      sizeOfFont: 16,
                      weight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ))
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
          onClick: () => Get.to(() =>  SelectFishingCategory(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}
