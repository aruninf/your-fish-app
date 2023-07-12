import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/HOME/main_home.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';


class AddYourGear extends StatelessWidget {
  const AddYourGear({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SizedBox(
                width: double.infinity,
                height: 30,
                child: CommonButton(
                  onClick: () {

                  },
                  btnBgColor: btnColor,
                  btnText: 'Add',
                  btnTextColor: primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            // Expanded(
            //     child: GridView.builder(
            //       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            //
            //       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           mainAxisSpacing: 16,crossAxisSpacing: 16,
            //           childAspectRatio: 4/5
            //       ),
            //       itemCount: gearData.length,
            //       itemBuilder: (context, index) =>  Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(width: 0.67,color: Colors.white),
            //           borderRadius: BorderRadius.circular(16),
            //
            //         ),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             ClipRRect(
            //                 borderRadius: BorderRadius.circular(16),
            //                 child: Image.asset("${gearData[index].fishImage}",
            //                   height: Get.width*0.45,fit: BoxFit.cover,width: double.infinity,)
            //             ),
            //             Padding(
            //               padding:const EdgeInsets.all(5.0),
            //               child: Text("${gearData[index].fishName}",
            //                 maxLines: 1,
            //                 textAlign:TextAlign.center,style: const TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700
            //
            //                 ),),
            //             )
            //           ],
            //         ),
            //       ),
            //     )
            // )

            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    text: 'Shimano SLX Baitcast Combo',
                    sizeOfFont: 16,
                    weight: FontWeight.w800,
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
          onClick: () => Get.to(() => const MainHome(),
              transition: Transition.rightToLeft),
        ),
      ),
    );
  }
}

class FishWidgetItem extends StatelessWidget {
  const FishWidgetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.43,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                fishingImage,
                fit: BoxFit.cover,
                height: 120,
                width: double.infinity,
              )),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: CustomText(
              text: "Fishing Rod",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
