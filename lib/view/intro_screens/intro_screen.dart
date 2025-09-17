import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/intro_screen_controller.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  IntroScreenController controller = Get.put(IntroScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: '',isLeading: false,),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: (v) {
              controller.count.value = v;
            },
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            reverse: false,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    // height: Get.height * 0.65,
                    width: Get.width,
                    child: Image.asset(
                      width: Get.width * 0.80,
                      height: Get.height * 0.45,
                      list[index],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    // height: Get.height * 0.35,
                    width: Get.width,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 10,
              bottom: 45,
              child: TextButton(
                  onPressed: () {
                    controller.count.value =
                        controller.pageController.page!.toInt();
                    controller.pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                    if (controller.count.value == list.length - 1) {
                      Get.offAllNamed(PageNames.loginScreen);
                    }
                  },
                  style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory),
                  child: Text("Prev",
                      style: AppTextStyle.semiBoldBlack(fontSize: 18)))),
          Positioned(
            left: 50,
            right: 50,
            bottom: 53,
            child: Obx(() => DotsIndicator(
                position: controller.count.value.toDouble(),
                dotsCount: list.length,
                decorator: DotsDecorator(
                  color: Color.fromRGBO(23, 34, 59, 0.2),
                  activeColor: AppColor.primaryColor,
                  size: Size.square(10),
                  activeSize: Size(45, 8),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ))),
          ),
          Positioned(
              right: 10,
              bottom: 45,
              child: TextButton(
                  onPressed: () {
                    controller.pageController.page!
                        .toInt()
                        .toString()
                        .logCustom();
                    controller.count.value =
                        controller.pageController.page!.toInt();
                    controller.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                    if (controller.count.value == list.length - 1) {
                      Get.offAllNamed(PageNames.loginScreen);
                      // Get.offAll(() => LoginScreen());
                    }
                  },
                  style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory),
                  child: Obx(() => Text(
                      controller.count.value != list.length - 1
                          ? "Next"
                          : "Finish",
                      style: AppTextStyle.semiBoldBlack(
                        fontSize: 18,
                      ))))),
          Positioned(
              bottom: Get.height / 5,
              left: 50,
              right: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(myText(controller.count.value),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.semiBoldPrimary(
                        fontSize: 18,
                      ))),
                  Obx(() => Text(subHeadingText(controller.count.value),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regularCustom(
                          fontSize: 16, color: AppColor.black1212OP60))),
                ],
              ))
        ],
      ),
    );
  }

  List<String> list = [
    AppImages.logo,
    AppImages.logo,
  ];

  String myText(int value) {
    if (value == 0) {
      return "Your Weekly Therapy, Simplified";
    } else {
      return "Your Weekly Therapy, Simplified";
    }
  }

  String subHeadingText(int value) {
    if (value == 0) {
      return "Stay on track with your daily activities and group sessions—anytime, anywhere";
    } else {
      return "Purchase genuine parts and accessories from verified sellers.";
    }
  }
}
