import 'dart:convert';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController reasonController = TextEditingController();

  deleteAccount() async {
    isLoading.value = true;

    final response = await API.instance.post(
        endPoint: APIEndPoints.deleteAccount,
        params: {"reason": reasonController.text});

    isLoading.value = false;

    try {
      final data = jsonDecode(response.body);
      final status = data['statusCode'];
      final message = data['message'];

      if (status == 1) {
        message.toString().showSnackBar();

        Get.offAllNamed(PageNames.loginScreen);
      } else {
        message.toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
