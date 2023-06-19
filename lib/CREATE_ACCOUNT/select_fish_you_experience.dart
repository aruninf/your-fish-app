import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fish_you_experience.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fishing_location.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'get_start.dart';

class SelectFishYouExperience extends StatefulWidget {
  const SelectFishYouExperience({super.key});

  @override
  State<SelectFishYouExperience> createState() => _SelectFishYouExperienceState();
}

class _SelectFishYouExperienceState extends State<SelectFishYouExperience> {

  Widget appBarTitle =  const Text("Search Fish",
    style:  TextStyle(color: Colors.white,fontSize: 12),);
  Icon actionIcon =  const Icon(Icons.search, color: Colors.white,);
  final key =  GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery =  TextEditingController();
  late List<String> _list;
  String _searchText = "";

  _searchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      }
      else {
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
    setState(() {
    });
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon =  const Icon(Icons.search, color: Colors.white,);
      appBarTitle = const Text("Search Fish",
        style:  TextStyle(color: Colors.white,fontSize: 12),);
      _searchQuery.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Image.asset(fishTextImage,height: 50,width: 100,color: secondaryColor,),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: fishColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child:  Text( 'Select Fish you have\nExperience in catching',
              style: TextStyle(
                  color: fishColor,
                  fontFamily: "Rodetta",
                  fontSize: 22,
                  fontWeight: FontWeight.w600
              ),),
          ),

          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 14),
            child: CustomSearchField(
              hintText: 'Search Fish',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,crossAxisSpacing: 16
            ),
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.67,color: Colors.white),
                borderRadius: BorderRadius.circular(16),

              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(fishPlaceHolder,
                        height: Get.width*0.33,fit: BoxFit.cover,width: double.infinity,)
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Broadbill Swordfish",
                      maxLines: 1,
                      textAlign:TextAlign.center,style: TextStyle(
                        color: Colors.white,

                      ),),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () => Get.to(()=>const SelectFishingLocation(), transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}

