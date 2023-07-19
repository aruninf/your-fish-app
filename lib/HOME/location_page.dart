import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:yourfish/UTILS/app_color.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../UTILS/app_images.dart';

class LocationPage extends StatelessWidget {
  LocationPage({Key? key}) : super(key: key);
  final controller=Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Obx(() => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Enable Location',
                  style: TextStyle(
                      color:  secondaryColor,
                      fontFamily: "Rodetta",
                      fontSize: 20,
                      height: 1.5,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(locationImage,height: 200,width: 200,),
                Text('LAT: ${controller.currentPosition.value.latitude ?? ""}',style: TextStyle(color: secondaryColor),),
                Text('LNG: ${controller.currentPosition.value.longitude ?? ""}',style: TextStyle(color: secondaryColor)),
                Text('ADDRESS: ${controller.currentAddress.value ?? ""}',textAlign: TextAlign.center,style: TextStyle(color: secondaryColor)),
                const SizedBox(height: 16),

                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: CommonButton(
                    btnBgColor: fishColor,
                    btnTextColor: secondaryColor,
                    btnText: "Get Location",
                    onClick: controller.getCurrentPosition,
                  ),
                ),
                const SizedBox(height: 16),

                TextButton(onPressed: ()=>Get.back(), child: Text("Back",style: TextStyle(color: secondaryColor),))

              ],
            ),
          ),
        )),
      ),
    );
  }
}
