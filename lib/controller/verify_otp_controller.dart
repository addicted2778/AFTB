import 'dart:async';
import 'dart:convert';

import 'package:atfb/controller/forgot_password_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isResendLoading = false.obs;
  var counter = 60.obs;
  late Timer timer;
  var isResend = false.obs;

  TextEditingController otpTextfield = TextEditingController();

  void startTimer() {
    counter.value = 60;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (counter.value > 0) {
          counter.value--;
        } else if (counter.value == 0) {
          isResend.value = true;
        } else {
          timer.cancel();
        }
      },
    );
  }

  stopTimer() {
    timer.cancel();
  }

  verifyOtp({
    required String email,
  }) async {
    isLoading.value = true;

    final response = await API.instance.post(
        endPoint: APIEndPoints.verifyOtp,
        params: {
          'email': email,
          'otp': otpTextfield.text,
          "otp_type": "forgot_password"
        });

    isLoading.value = false;

    try {
      final data = json.decode(response.body);
      final status = data['statusCode'];

      if (status == 1) {
        Get.toNamed(PageNames.newPassword, arguments: [email]);
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }

  resendOtp({required String email}) async {
    timer.cancel();
    startTimer();
    isResend.value = false;

    final response =
        await API.instance.post(endPoint: APIEndPoints.resendOtp, params: {
      "email": email,
      "otp_type": "forgot_password",
    });

    try {
      final data = json.decode(response.body);
      final status = data['statusCode'];
      if (status == 1) {
        // data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
