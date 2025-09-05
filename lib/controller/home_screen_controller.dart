import 'dart:convert';

import 'package:atfb/controller/forgot_password_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/const.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/dashboard_model.dart';
import '../model/site_setting_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  var dashboardModel = DashboardModel().obs;
  var siteSettingModel = SiteSettingModel().obs;

  String getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, d MMMM yyyy').format(now);
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
        siteSettingModel.value = SiteSettingModel.fromJson(data);
        siteSettingData.value = siteSettingModel.value.data!;
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }

  dashBoard({String start_date = '', String? end_date = ''}) async {
    isLoading.value = true;

    final response =
        await API.instance.post(endPoint: APIEndPoints.timetable, params: {
      "start_date": start_date,
      "end_date": end_date,
    });

    isLoading.value = false;

    try {
      final data = json.decode(response.body);

      final status = data['statusCode'];

      if (status == 1) {
        dashboardModel.value = DashboardModel.fromJson(data);
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
