import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import '../UTILS/app_color.dart';

class CustomSearchField extends StatelessWidget{
  const CustomSearchField({super.key,
    this.controller,
    required this.hintText,
  });
  final TextEditingController? controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.06,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      alignment: Alignment.center,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(30),
            color: btnColor,
            boxShadow: const [BoxShadow(
              blurRadius: 5.0,
              color: Colors.black26,
            ),]
        ),
        child: TextFormField(
            keyboardType: TextInputType.text,
            maxLines:1,

            style: const TextStyle(
                fontWeight: FontWeight.w800, fontSize: 13),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(PhosphorIcons.magnifying_glass),
                contentPadding:  EdgeInsets.zero,
                hintStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w800),
                hintText: hintText)));
  }

}