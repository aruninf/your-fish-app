import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'UTILS/app_color.dart';

class ImageSelectionScreen extends StatefulWidget {
  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<File> _selectedImages = [];

  Future<void> _selectImages() async {
    final picker = ImagePicker();
    List<XFile> pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      for (XFile imageFile in pickedImages) {
        File? croppedImage = await cropImage(imageFile);
        if (croppedImage != null) {
          setState(() {
            _selectedImages.add(croppedImage);
          });
        }
      }
    }
  }


  static Future<File?> cropImage(XFile? file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 70,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Image Cropper',

        ),
      ],
    );

    return File(croppedFile!.path);
  }


  // Future<XFile?> _cropImage(XFile imageFile) async {
  //   var croppedFile = await ImageCropper.cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //     compressQuality: 100,
  //   );
  //
  //   return croppedFile != null ? XFile(croppedFile.path) : null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Selection and Cropping'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _selectImages,
            child: const Text('Select Images'),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Image.file(_selectedImages[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
