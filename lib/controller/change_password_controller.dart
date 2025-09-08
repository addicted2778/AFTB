import 'dart:convert';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/const.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obscureCurrentPassword = true.obs;
  RxBool obscureNewPassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  changePassword() async {
    isLoading.value = true;

    final response =
        await API.instance.post(endPoint: APIEndPoints.resetPassword, params: {
      'email': siteSettingData.value.profile!.email!.toString(),
      'current_password': currentPasswordController.text,
      'new_password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    });

    isLoading.value = false;

    try {
      final data = jsonDecode(response.body);
      final status = data['statusCode'];
      final message = data['message'];

      if (status == 1) {
        Get.back();
        message.toString().showSnackBar();
      } else {
        message.toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
