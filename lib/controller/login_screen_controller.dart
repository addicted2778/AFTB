import 'dart:convert';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/const.dart';
import 'package:atfb/utils/global.dart';
import 'package:atfb/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var checkBoxEnable = true.obs;
  var isLoading = false.obs;
  var obscurePassword = true.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  userLogin() async {
    isLoading.value = true;

    final response = await API.instance.post(
        endPoint: APIEndPoints.userLogin,
        params: {
          "email": emailController.text,
          'password': passwordController.text
        });
    isLoading.value = false;

    try {
      final data = json.decode(response.body);
      final status = data['statusCode'];

      if (status == 1) {
        await Preferences.saveSharedPref(KEY_TOKEN, data['data']['token']);
        await Preferences.saveSharedPrefBool(KEY_LOGIN, true);
        Get.offAllNamed(PageNames.homeScreen);
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
