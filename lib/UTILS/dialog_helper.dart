import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/permission_services.dart';

import 'consts.dart';

class DialogHelper {
  //show error dialog
  static Future<void> showErrorDialog(
      {String title = 'Error',
      String? description = 'Something went wrong'}) async {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   title,
              //   style:
              //       const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              // ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description ?? 'Something went wrong',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text(
                  'OKAY',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showPermissionDialog(
      {String title = 'Permission',
      String? description =
          'You have permanently denied all permissions give permission in app setting'}) async {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.titleSmall,
              ),
              TextButton(
                onPressed: () async {
                  if (Get.isDialogOpen!) Get.back();
                  await openAppSettings();
                },
                child: const Text('Open Setting'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show loading
  static void showLoading([String? message]) {
    Get.dialog(Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const CircularProgressIndicator(),
      ),
    ));
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  static void selectImageFrom(
      {required Function(File? uri) onClick, required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      useRootNavigator: true,
      // set shape to make top corners rounded
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close_sharp),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () async {
                    if (Platform.isAndroid) {
                      bool per =
                          await PermissionService().requestPermissionPhotos();
                      if (!per) {
                        openAppSettings();
                      } else {
                        await Consts.imageFromCamera().then(
                          (value) {
                            // print("imageFromGallery=======================$value");
                            return onClick(value);
                          },
                        );
                      }
                    } else {
                      await Consts.imageFromCamera().then(
                        (value) {
                          // print("imageFromGallery=======================$value");
                          return onClick(value);
                        },
                      );
                    }

                    Get.back();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Camera",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 40.0),
                child: InkWell(
                  onTap: () async {
                    if (Platform.isAndroid) {
                      bool per =
                          await PermissionService().requestPermissionPhotos();
                      if (!per) {
                        openAppSettings();
                      } else {
                        await Consts.imageFromGallery().then((value) {
                          //print("imageFromGallery=======================$value");
                          return onClick(value);
                        });
                      }
                    } else {
                      await Consts.imageFromGallery().then((value) {
                        //print("imageFromGallery=======================$value");
                        return onClick(value);
                      });
                    }

                    Get.back();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Gallery",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
