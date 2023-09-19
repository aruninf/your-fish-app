import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';

class ImagePlaceHolderWidget extends StatelessWidget {
  const ImagePlaceHolderWidget({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fishingImage,
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }
}