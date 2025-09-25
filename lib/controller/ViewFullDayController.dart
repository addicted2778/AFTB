import 'dart:convert';

import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../export_files/export_files_must.dart';
import '../model/dashboard_model.dart';
import '../model/time_table_detail_model.dart';
import '../services/api_services.dart';

class ViewFullDayController extends GetxController {
  RxBool isLoading = false.obs;

  RxInt toScrollIndex = 0.obs;

  var dashboardModel = DashboardModel().obs;
  var timeTableDetailModel = TimeTableDetailModel().obs;

  Future<bool> dashBoard() async {
    isLoading.value = true;

    String start_date =
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    String end_date =
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

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

        for (int a = 0;
            a < dashboardModel.value.data!.timetable!.first.data!.length;
            a++) {
          DateTime now = DateTime.now();

          if (dashboardModel.value.data!.timetable!.first.data![a].startTime
                      .toString()
                      .split(':')
                      .first
                      .toString() ==
                  now.hour.toString() ||
              dashboardModel.value.data!.timetable!.first.data![a].endTime
                      .toString()
                      .split(':')
                      .first
                      .toString() ==
                  now.hour.toString()) {
            if (a > 4) {
              toScrollIndex.value = a - 2;
            } else {
              toScrollIndex.value = a;
            }
          }
        }

        return true;
      } else {
        data['message'].toString().showSnackBar();
        return false;
      }
      return false;
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
      return false;
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
