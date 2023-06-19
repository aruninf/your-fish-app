import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fishing_location.dart';
import 'package:yourfish/CREATE_ACCOUNT/upload_profile_picture.dart';
import 'package:yourfish/HOME/main_home.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'get_start.dart';

class AddYourGear extends StatefulWidget {
  const AddYourGear({super.key});

  @override
  State<AddYourGear> createState() => _AddYourGearState();
}

class _AddYourGearState extends State<AddYourGear> {

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
              heading: 'Add your gear',
              textColor: fishColor,

            ),
            const SizedBox(
              height: 16,
            ),

            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),

                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,crossAxisSpacing: 16,
                    childAspectRatio: 4/5
                ),
                itemCount: 10,
                itemBuilder: (context, index) =>  Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.67,color: Colors.white),
                    borderRadius: BorderRadius.circular(16),

                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(fishingImage,
                            height: Get.width*0.45,fit: BoxFit.cover,width: double.infinity,)
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
          onClick: () => Get.to(()=>const MainHome(), transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}

class FishWidgetItem  extends StatelessWidget {
  const FishWidgetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*0.43,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.white),
        borderRadius: BorderRadius.circular(16),

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
              child: Image.asset(fishingImage,
                fit: BoxFit.cover,height: 120,width: double.infinity,)),

          const Padding(
            padding: EdgeInsets.all(5.0),
            child: CustomText(text: "Fishing Rod",color: Colors.white,),
          )
        ],
      ),
    );
  }
}
