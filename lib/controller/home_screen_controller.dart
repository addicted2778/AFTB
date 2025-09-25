import 'dart:convert';

import 'package:atfb/controller/forgot_password_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/const.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/dashboard_model.dart';
import '../model/site_setting_model.dart';
import '../model/time_table_detail_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  var dashboardModel = DashboardModel().obs;
  var siteSettingModel = SiteSettingModel().obs;
  var timeTableDetailModel = TimeTableDetailModel().obs;

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

  Future<bool> timeTableDetail({
    required String timeTableId,
    required String startTime,
    required String endTime,
  }) async {
    showLoadingDialog();

    final response = await API.instance
        .post(endPoint: APIEndPoints.timetableDetails, params: {
      "time_table_id": timeTableId,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      "start_time": startTime,
      "end_time": endTime,
      // "time_table_id": '143',
      // "date": "2025-09-25",
      // "start_time": "11:00:00",
      // "end_time": "12:30:00",
    });

    // isLoadingDetail.value = false;
    hideLoadingDialog();

    try {
      final data = jsonDecode(response.body);
      final statusCode = data['statusCode'];

      if (statusCode == 1) {
        timeTableDetailModel.value = TimeTableDetailModel.fromJson(data);
        return true;
      } else {
        data['message'].toString().showSnackBar();
        return false;
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
      return false;
    }
  }

  void showLoadingDialog() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: AppColor.primaryColor,
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
