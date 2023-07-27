import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';

import '../../CONTROLLERS/post_controller.dart';
import '../../UTILS/consts.dart';

class MyFishUnlockedWidget extends StatelessWidget {
  MyFishUnlockedWidget({super.key});
  final controller = Get.find<UserController>();

  void getMyUnlockFish(){
    var data={
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(Duration.zero,() => controller.getFish(data),);
  }
  @override
  Widget build(BuildContext context) {
    getMyUnlockFish();
    return GridView.builder(
      itemCount: fishData.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 5 / 4),
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
                child: Image.asset(
                  fishData[index].fishImage ?? '',
                  height: Get.width * 0.25,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fishData[index].fishName ?? '',
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
