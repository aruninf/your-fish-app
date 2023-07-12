import 'package:get/get.dart';

import '../PROFILE/faq_screen.dart';

class SettingController extends GetxController {
  var selectedCategories = [].obs;
  final listOfSettings = [
    "Notifications",
    "Invite Friends",
    "Terms & Conditions",
    "Privacy Policy",
    "FAQ's",
    "Contact Us"
  ];

  var listOfOpen = [].obs;

  late List<FaqModel> listOfFaq = [
    FaqModel(
        title: "How do i hide my location?",
        subTitle:
            "Go to profile setting change Go to profile setting change Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle:
            "Go to profile setting change Go to profile setting change Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
    FaqModel(
        title: "How do i hide my location?",
        subTitle: "Go to profile setting change location"),
  ];
}
