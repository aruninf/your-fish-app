import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/setting_controller.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class FaqModel {
  String? title = "";
  String? subTitle = "";

  FaqModel({this.title, this.subTitle});
}



class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});


  final controller=Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: "FAQ'S",
              textColor: secondaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => Expanded(
              child: ListView.builder(
                itemCount: controller.listOfFaq.length,
                itemBuilder: (context, index) => Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 0.78, color: Colors.white),
                  ),
                  child: ListTile(
                    dense: true,
                    title: CustomText(
                      text: "${controller.listOfFaq[index].title}".toUpperCase(),
                      color: fishColor,
                      sizeOfFont: 17,
                      weight: FontWeight.w800,
                    ),
                    subtitle: Text(
                      controller.listOfOpen.contains(index)
                          ? "${controller.listOfFaq[index].subTitle}"
                          : "",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    trailing: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          if (controller.listOfOpen.contains(index)) {
                            controller.listOfOpen.remove(index);
                          } else {
                            controller.listOfOpen.add(index);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            PhosphorIcons.caret_down,
                            color: secondaryColor,
                          ),
                        )),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
