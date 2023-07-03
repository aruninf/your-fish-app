import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.controller,
    required this.hintText,
  });

  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: btnColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.black26,
            ),
          ]),

      child: Text(
        'Search',
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      // child: TextFormField(
      //     keyboardType: TextInputType.text,
      //     textAlign: TextAlign.center,
      //     style: const TextStyle(
      //         fontWeight: FontWeight.w700, fontSize: 13),
      //     decoration: InputDecoration(
      //         border: InputBorder.none,
      //         //prefixIcon: const Icon(PhosphorIcons.magnifying_glass),
      //         contentPadding:  const EdgeInsets.symmetric(horizontal: 6,vertical: 0),
      //         hintStyle: const TextStyle(
      //             fontSize: 14, fontWeight: FontWeight.w700),
      //         hintText: hintText))
    );
  }
}
