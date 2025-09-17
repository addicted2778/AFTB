import 'dart:convert';

import 'package:atfb/controller/forgot_password_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool passwordObscurePassword = true.obs;
  RxBool confirmPasswordObscurePassword = true.obs;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  updatePassword({required String email}) async {
    isLoading.value = true;

    final response =
        await API.instance.post(endPoint: APIEndPoints.updatePassword, params: {
      "email": email,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
    });

    isLoading.value = false;

    try {
      final data = json.decode(response.body);
      final status = data['statusCode'];

      if (status == 1) {
        Get.offAllNamed(PageNames.loginScreen);
        data['message'].toString().showSnackBar();
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
