import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../UTILS/app_images.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator())),
      errorWidget: (context, url, error) => Image.asset(
        fishingImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
