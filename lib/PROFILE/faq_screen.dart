import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class FaqModel {
  String? title = "";
  String? subTitle = "";

  FaqModel({this.title, this.subTitle});
}

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late List<int> listOfOpen = [];

  late List<FaqModel> listOfFaq = [
    FaqModel(
        title: "How do i hide my location?",
        subTitle:
            "Go to profile setting change Go to profile setting change Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle:
            "Go to profile setting change Go to profile setting change Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   titleSpacing: 0,
      //   title: const Text(
      //   "FAQ'S",style: TextStyle(
      //   fontSize: 16,fontFamily: 'Rodetta',
      //   color: secondaryColor
      //   ),),
      //   leading: IconButton(
      //     onPressed: () => Get.back(),
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //   ),
      // ),
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
            Expanded(
              child: ListView.builder(
                itemCount: listOfFaq.length,
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
                      text: "${listOfFaq[index].title}".toUpperCase(),
                      color: fishColor,
                      sizeOfFont: 17,
                      weight: FontWeight.w800,
                    ),
                    subtitle: Text(
                      listOfOpen.contains(index)
                          ? "${listOfFaq[index].subTitle}"
                          : "",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    trailing: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          setState(() {
                            if (listOfOpen.contains(index)) {
                              listOfOpen.remove(index);
                            } else {
                              listOfOpen.add(index);
                            }
                          });
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
            ),
          ],
        ),
      ),
    );
  }
}
