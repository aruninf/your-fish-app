import 'package:flutter/material.dart';

import '../CONTROLLERS/user_controller.dart';
import '../MODELS/fish_response.dart';
import '../UTILS/app_color.dart';
import 'package:get/get.dart';
class FishItemSelectWidget extends StatelessWidget {
  const FishItemSelectWidget({super.key,required this.fishData,required this.selectedFishInterest});

  final List<dynamic> selectedFishInterest;
  final FishData fishData;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        border: selectedFishInterest.contains(
            fishData.id)
            ?  Border.all(width: 2, color: fishColor) : Border.all(width: 0.67, color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          if (selectedFishInterest
              .contains(fishData.id)) {
            selectedFishInterest
                .remove(fishData.id);
          } else {
            selectedFishInterest
                .add(fishData.id);
          }
          print(selectedFishInterest);
        },
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  fishData.fishImage ??
                      '',
                  height: Get.width * 0.25,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fishData.fishName ?? '',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
