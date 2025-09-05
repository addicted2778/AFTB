import 'dart:convert';

import 'package:atfb/controller/login_screen_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailTextfield = TextEditingController();

  forgotPassword() async {
    isLoading.value = true;

    final response = await API.instance.post(
        endPoint: APIEndPoints.forgotPassword,
        params: {"email": emailTextfield.text});
    isLoading.value = false;

    try {
      final data = jsonDecode(response.body);
      final status = data['statusCode'];

      if (status == 1) {
        Get.toNamed(PageNames.verifyOtp, arguments: [emailTextfield.text]);
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().showSnackBar();
      stackTrace.toString().showSnackBar();
    }
  }
}
