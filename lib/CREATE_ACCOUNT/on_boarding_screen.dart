import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:yourfish/CREATE_ACCOUNT/get_start.dart';
import 'package:yourfish/CUSTOM_WIDGETS/common_button.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/app_images.dart';
import 'package:yourfish/UTILS/app_strings.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late int index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.09,
            ),
            Image.asset(
              fishTextImage,
              height: Get.width * 0.4,
              width: Get.width * 0.6,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Colors.white)),
              child: Column(children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                SizedBox(
                  height: Get.height * 0.32,
                  width: Get.width,
                  child: PageIndicatorContainer(
                    align: IndicatorAlign.bottom,
                    length: 3,
                    indicatorSpace: 3.0,
                    padding: const EdgeInsets.all(10),
                    indicatorColor: Colors.white30,
                    indicatorSelectorColor: btnColor,
                    shape: IndicatorShape.circle(size: 12),
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: 3,
                        onPageChanged: (value) {
                          setState(() {
                            index = value;
                          });
                        },
                        itemBuilder: (context, position) {
                          return index == 0
                              ? const SliderWidget(
                                  title: textTitle1,
                                  description: textText1,
                                  headingColor: fishColor,
                                )
                              : index == 1
                                  ? SliderWidget(
                                      title: textTitle2,
                                      description: textText2,
                                      headingColor: index == 1
                                          ? secondaryColor
                                          : fishColor,
                                    )
                                  : const SliderWidget(
                                      title: textTitle3,
                                      description: textText3,
                                      headingColor: fishColor,
                                    );
                        }),
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  height: 55,
                  child: CommonButton(
                    btnBgColor: index == 1 ? fishColor : secondaryColor,
                    btnTextColor: primaryColor,
                    btnText: next,
                    onClick: () {
                      if (index < 2) {
                        _pageController.animateToPage(
                          (_pageController.page ?? 0).toInt() + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      } else {
                        Get.to(() =>  GetStartScreen(),
                            transition: Transition.rightToLeft);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ]),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                fishLeftImage,
                height: Get.width * 0.3,
                width: Get.width * 0.65,
                fit: BoxFit.fill,
                color: index == 1 ? secondaryColor : fishColor,
              ),
            ),
          ]),
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.headingColor});

  final String title;
  final String description;
  final Color headingColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Rodetta",
            fontSize: 22,
            color: headingColor,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          child: Text(
            description,
            style:
                const TextStyle(color: Colors.white, height: 1.4, fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
