import 'dart:async';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMethod();
  }

  initMethod() async {
    final login = await Preferences.getSharedPrefBool(KEY_LOGIN);

    Timer(
      const Duration(seconds: 3),
      () {
        if (login != null) {
          if (login) {
            Get.offAllNamed(PageNames.homeScreen);
          } else {
            Get.offAllNamed(PageNames.loginScreen);
          }
        } else {
          Get.offAllNamed(PageNames.loginScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AppImages.logo,
          height: Get.height * 0.40,
          width: Get.width * 0.80,
        ),
      ),
    );
  }
}
