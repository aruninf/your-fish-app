import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/UTILS/app_images.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../UTILS/consts.dart';
class MyGearWidget extends StatelessWidget {
  MyGearWidget({super.key});
  final controller = Get.find<UserController>();

  void getMyGear(){
    var data={
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(Duration.zero,() => controller.getFishGear(data),);
  }
  @override
  Widget build(BuildContext context) {
    getMyGear();
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 4 / 5),
      itemCount: controller.fishingGear.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.67, color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "${controller.fishingGear[index].image}",
                  height: Get.width * 0.45,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                   fishingImage,
                    height: Get.width * 0.45,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "${controller.fishingGear[index].title}",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
