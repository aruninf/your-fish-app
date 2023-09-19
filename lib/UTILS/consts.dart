import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:yourfish/UTILS/app_color.dart';


class Consts {
  /// Image Picker ///
  static Future<File?> imageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 600,
        maxWidth: 800,
        imageQuality: 50);
    if (pickedFile != null) {
      return cropFile(pickedFile);
    }
    return null;
  }

  static Future<File?> imageFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 600,
        maxWidth: 800,
        imageQuality: 50);
    if (pickedFile != null) {
      return cropFile(pickedFile);
    }
    return null;
  }

  static Future<File?> cropFile(XFile? file) async {
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


  static showSnackBarError(String? title,String? message){
    Get.snackbar(title ?? '', message ?? '',
        colorText: Colors.deepOrangeAccent, snackPosition: SnackPosition.TOP);
  }

  static showSnackBarSuccess(String? title,String? message){
    Get.snackbar(title ?? '', message ?? '',
        colorText: Colors.green, snackPosition: SnackPosition.TOP);
  }


/// Date Formats //////////////////////////////////////
  static String parseTimeStamp(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value).toLocal();
    var d12 = DateFormat('hh:mm a').format(date);
    return d12;
  }

  static String parseTimeHH(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value).toLocal();
    var d12 = DateFormat('HH:mm').format(date);
    return d12;
  }

  static String parseTimeStamp1(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value).toLocal();
    var d12 = DateFormat('hh:mm a, MMM dd').format(date);
    return d12;
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  static String formatDateTimeToMMM(String dateTime) {
    var date = DateTime.parse(dateTime);
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatDateTimeToHHMM(String dateTime) {
    var date = DateTime.parse(dateTime);
    return DateFormat('hh:mm a').format(date);
  }
}
