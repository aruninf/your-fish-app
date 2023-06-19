import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/PROFILE/edit_profile_screen.dart';
import 'package:yourfish/UTILS/app_images.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../PROFILE/my_future_fish.dart';
import '../PROFILE/my_map_screen.dart';
import '../UTILS/app_color.dart';

class ProfileSection extends StatefulWidget{
  ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {

  String? selectedIndex ="My Post";
  final listOfProfileSection=[
    "My Post",
    "My Map",
    "Fish Unlocked",
    "My Future Fish",
    "My Gear"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      extendBody: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              leading: const CircleAvatar(
                backgroundColor: Colors.white30,
                maxRadius: 25,
                child: CustomText(
                  text: 'Photo',
                  sizeOfFont: 11,
                  color: Colors.white30,
                ),
              ),
              title: const CustomText(
                text: 'Alex Brown',
                color: Colors.white,
                weight: FontWeight.w800,
                sizeOfFont: 18,
              ),
              subtitle: const CustomText(
                text: 'Gold Cost, au',
                color: Colors.white,
                sizeOfFont: 15,
                weight: FontWeight.w500,
              ),
              trailing: SizedBox(
                height: 30,
                child: TextButton(
                    onPressed: () => Get.to(const EditProfileScreen(),transition: Transition.rightToLeft),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                width: 0.67, color: Colors.white))),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 4),
              child:  Text( 'Suggested Friends',
                style: TextStyle(
                    color: secondaryColor,
                    fontFamily: "Rodetta",
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),
            ),
            const SizedBox(height: 8,),

            SizedBox(
              height: Get.height*0.15,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(listOfProfileSection.length, (index) => Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0.67,color: Colors.white)
                  ),
                  child:  Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white30,
                        radius: 22,
                      ),
                      const SizedBox(height: 5,),
                      const CustomText(text: "Shoppe Will",color: btnColor,weight: FontWeight.w800,sizeOfFont: 12,),
                      const SizedBox(height: 6,),
                      SizedBox(
                        height: 28,
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: fishColor,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w800),
                            )),
                      ),
                    ],
                  ),
                )),
              ),
            ),
            const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: Get.height*0.055,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(listOfProfileSection.length, (index) => Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: listOfProfileSection[index] == selectedIndex ? secondaryColor : btnColor,
                    ),
                    child:  InkWell(
                      onTap: () => setState(() {
                        selectedIndex=listOfProfileSection[index];
                      }),
                      child: Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        child:  CustomText(text: listOfProfileSection[index],weight: FontWeight.w700,sizeOfFont: 13,),
                      ),
                    ),
                  )),
                ),
              ),
            ),

            Expanded(
                child: selectedIndex=="My Post" ?
                    const MyPostWidget() :
                selectedIndex=="My Map" ? const MyProfileMapWidget(isTopSpots: false,)
                    :  selectedIndex=="Fish Unlocked" ? const MyFishUnlockedWidget() :
                selectedIndex=="My Future Fish" ? const MyFutureFishWidget(): const MyGearWidget()
            ),
          ],
        ),
      ),
    );
  }
}


class MyGearWidget extends StatelessWidget {
  const MyGearWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),

      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,crossAxisSpacing: 16,
        childAspectRatio: 4/5
      ),
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
    );
  }
}

class MyFishUnlockedWidget  extends StatelessWidget{
  const MyFishUnlockedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,crossAxisSpacing: 16
        ),
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
    );
  }
}



class MyPostWidget extends StatelessWidget {
  const MyPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      itemCount: 19,
      itemBuilder: (context, index) =>
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(fishingImage,height: Get.width*0.32,width: Get.width*0.32,fit: BoxFit.cover,)),
    );
  }
}