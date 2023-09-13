import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CONTROLLERS/setting_controller.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: "Notifications",
              textColor: secondaryColor,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.listOfNotification.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      child: Row(
                        children: [
                          CustomText(
                            text: controller.listOfNotification[index],
                            color: Colors.white,
                            sizeOfFont: 14,
                            weight: FontWeight.w800,
                          ),
                          const Spacer(),
                          Obx(() => Switch(
                            activeTrackColor: fishColor,
                            activeColor: primaryColor,
                            value: controller.listOfOn.contains(controller.listOfNotification[index]),
                            onChanged: (value) {
                              if (controller.listOfOn.contains(controller.listOfNotification[index])) {
                                controller.listOfOn.remove(controller.listOfNotification[index]);
                              } else {
                                controller.listOfOn.add(controller.listOfNotification[index]);
                              }
                              var data={
                                "new_message": controller.listOfOn.contains("New Message"),
                                "new_fish_unlocked": controller.listOfOn.contains("New Fish Unlocked"),
                                "bites_100": controller.listOfOn.contains("100 Bites"),
                                "comment": controller.listOfOn.contains("Comment"),
                                "new_location": controller.listOfOn.contains("New Location"),
                                "new_follower": controller.listOfOn.contains("New Follower"),
                                "new_share_on_post": controller.listOfOn.contains("New Share on Post")
                              };
                              controller.updatePublicFeedRadios(data);
                            },
                          ))
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
