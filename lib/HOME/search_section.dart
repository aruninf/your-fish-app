import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/HOME/profile_section.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../PROFILE/my_future_fish.dart';
import '../PROFILE/my_map_screen.dart';
import '../UTILS/app_color.dart';

class SearchSection extends StatefulWidget{
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late String? selectedIndex ="My Post";

  final listOfBeach=[
    "Beach Name 1",
    "Beach Name 2",
    "Beach Name 3",
    "Beach Name 4",
    "Beach Name 5"
  ];

  final listOfFilter=[
    "Posts",
    "Friend Request",
    "Find a buddy",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: Get.height*0.055,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(listOfFilter.length, (index) => Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: listOfFilter[index] == selectedIndex ? secondaryColor : btnColor,
                  ),
                  child:  InkWell(
                    onTap: () => setState(() {
                      selectedIndex=listOfFilter[index];
                    }),
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child:  CustomText(text: listOfFilter[index],weight: FontWeight.w600,sizeOfFont: 13,),
                    ),
                  ),
                )),
              ),
            ),
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 14),
            child: CustomSearchField(
              hintText: 'Search Fish',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: Get.height*0.055,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(listOfBeach.length, (index) => Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: listOfBeach[index] == selectedIndex ? secondaryColor : btnColor,
                  ),
                  child:  InkWell(
                    onTap: () => setState(() {
                      selectedIndex=listOfBeach[index];
                    }),
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child:  CustomText(text: listOfBeach[index],weight: FontWeight.w500,sizeOfFont: 13,),
                    ),
                  ),
                )),
              ),
            ),
          ),

          const Expanded(
              child: MyPostWidget()
          ),

        ],
      ),
    );
  }
}