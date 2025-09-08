import 'package:atfb/utils/const.dart';
import 'package:atfb/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  var pageController = PageController(initialPage: 0);
  RxInt count = 0.obs;
  RxBool isActive = false.obs;
  @override
  void onInit() {
    savePreference();
    super.onInit();
    pageController.addListener(() {
      pageController.page;
    });
  }
}

savePreference() async {
  await Preferences.saveSharedPrefBool(KEY_INTRO_SCREEN, true);
}
