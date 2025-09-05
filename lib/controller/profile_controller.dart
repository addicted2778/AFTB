import 'dart:convert';

import 'package:atfb/controller/forgot_password_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:atfb/utils/preferences.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  logout() async {
    isLoading.value = true;

    final response =
        await API.instance.post(endPoint: APIEndPoints.logout, params: {});

    try {
      final data = json.decode(response.body);
      final status = data['statusCode'];

      if (status == 1) {
        await Preferences.clearAllPref();
        Get.offAllNamed(PageNames.loginScreen);
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }

    isLoading.value = false;
  }
}
