import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageViewDialog extends StatelessWidget {
  final String imageUrl;

  const ImageViewDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        height: 300, // Adjust the height as needed
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
