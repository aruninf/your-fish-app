import 'package:flutter/material.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<String> listOfOn = [];
  late List<String> listOfNotification = [
    "New Message",
    "New Fish Unlocked",
    "100 Bites",
    "Comment",
    "New Location",
    "New Follower",
    "New Share on Post"
  ];

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
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: listOfNotification.length,
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
                            text: listOfNotification[index],
                            color: Colors.white,
                            sizeOfFont: 14,
                            weight: FontWeight.w800,
                          ),
                          const Spacer(),
                          Switch(
                            activeTrackColor: fishColor,
                            activeColor: primaryColor,
                            value: listOfOn.contains(listOfNotification[index]),
                            onChanged: (value) {
                              setState(() {
                                // var data={
                                //   "public_feed":listOfNotification[index]
                                // };
                                // controller.updatePublicFeedRadios(data);
                                if (listOfOn
                                    .contains(listOfNotification[index])) {
                                  listOfOn.remove(listOfNotification[index]);
                                } else {
                                  listOfOn.add(listOfNotification[index]);
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
