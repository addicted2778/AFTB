import 'dart:convert';
import 'dart:io';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/model/site_setting_model.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';

import '../utils/const.dart';

class EditProfileController extends GetxController {
  var isLoading = false.obs;
  RxString imagePath = ''.obs;

  TextEditingController firstNController = TextEditingController();
  TextEditingController lastNController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNController = TextEditingController();
  TextEditingController ePhoneNController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  updateProfile() async {
    isLoading.value = true;

    final response = await API.instance.postImage(
        endPoint: APIEndPoints.updateProfile,
        params: {
          "first_name": firstNController.text,
          "last_name": lastNController.text,
          "phone_number": phoneNController.text,
          "emergency_phone_number": ePhoneNController.text,
          "date_of_birth": dobController.text
              .toString()
              .split('.')
              .reversed
              .join('-')
              .toString(),
          "address": addressController.text,
        },
        fileParams: 'profile_photo',
        file: File(imagePath.value));

    isLoading.value = false;

    try {
      final data = jsonDecode(response.body);
      final status = data['statusCode'];

      if (status == 1) {
        siteSetting();
        Get.back();
        data['message'].toString().showSnackBar();
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }

  siteSetting() async {
    isLoading.value = true;

    final response =
        await API.instance.post(endPoint: APIEndPoints.siteSetting, params: {});

    isLoading.value = false;

    try {
      final data = json.decode(response.body);

      final status = data['statusCode'];

      if (status == 1) {
        SiteSettingModel siteSettingModel = SiteSettingModel.fromJson(data);
        siteSettingData.value = siteSettingModel.data!;
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
