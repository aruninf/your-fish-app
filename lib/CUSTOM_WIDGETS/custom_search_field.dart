import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../UTILS/app_color.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.controller,
    required this.hintText, this.onChanges, this.clear,this.isClearIcon, this.onEditingComplete
  });

  final TextEditingController? controller;
  final String hintText;
  final Function(String)? onChanges;
  final Function()? onEditingComplete;
  final VoidCallback? clear;
  final bool? isClearIcon;

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
          controller: controller,
          onFieldSubmitted: onChanges,

          //onEditingComplete: onEditingComplete,
          //onChanged: onChanges,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 13),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(PhosphorIcons.magnifying_glass),
              suffixIcon: (isClearIcon ?? false)  ?  InkWell(
                onTap: clear,
                  child:  Icon(PhosphorIcons.x_circle_fill,color: Colors.grey.shade400,)):const SizedBox.shrink(),
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
