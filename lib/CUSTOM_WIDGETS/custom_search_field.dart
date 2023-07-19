import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3.0,
              color: Colors.black26,
            ),
          ]
      ),

      // child: Text(
      //   'Search',
      //   style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      // ),
      child: TextFormField(
          keyboardType: TextInputType.text,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.search,
          autofocus: false,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 13),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(PhosphorIcons.magnifying_glass),
              contentPadding:  const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
              hintStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              ),
              hintText: hintText)
      )
    );
  }
}
