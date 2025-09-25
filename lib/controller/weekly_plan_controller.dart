import 'dart:convert';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/model/dashboard_model.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';

import '../model/time_table_detail_model.dart';
import '../view/dashboard/weekly_plan/weekly_plan.dart';

class WeeklyPlanController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingDetail = false.obs;
  RxBool isShowMembers = false.obs;

  RxList<Meeting> totalMeetings = <Meeting>[].obs;
  var model = DashboardModel().obs;
  var timeTableDetailModel = TimeTableDetailModel().obs;

  weeklyData(
      {required DateTime startDate,
      required DateTime endDate,
      bool isCallingFirstTime = false}) async {
    isLoading.value = isCallingFirstTime;

    final response =
        await API.instance.post(endPoint: APIEndPoints.timetable, params: {
      "start_date":
          "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      "end_date":
          "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    });

    isLoading.value = false;

    try {
      final data = jsonDecode(response.body);
      final status = data['statusCode'];
      if (status == 1) {
        model.value = DashboardModel.fromJson(data);
        totalMeetings.clear();
        for (int a = 0; a < model.value.data!.timetable!.length; a++) {
          for (int b = 0;
              b < model.value.data!.timetable![a].data!.length;
              b++) {
            DateTime startTime = DateTime.parse(
                '${model.value.data!.timetable![a].data![b].date} ${model.value.data!.timetable![a].data![b].startTime}');
            DateTime endTime = DateTime.parse(
                '${model.value.data!.timetable![a].data![b].date} ${model.value.data!.timetable![a].data![b].endTime}');
            totalMeetings.add(Meeting(
                model.value.data!.timetable![a].data![b].activity!.name!,
                startTime,
                endTime,
                AppColor.hex(model
                    .value.data!.timetable![a].data![b].activity!.colorCode!),
                false));
          }
        }
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }

  DateTime getStartOfWeek(DateTime date) {
    int dayOfWeek = date.weekday;
    return date.subtract(Duration(days: dayOfWeek % 7)); // Sunday
  }

  DateTime getEndOfWeek(DateTime date) {
    int dayOfWeek = date.weekday;
    return date
        .add(Duration(days: 7 - (dayOfWeek % 7)))
        .subtract(const Duration(days: 1)); // Saturday
  }

  void onDateChanged(DateTime newDate) {
    DateTime newStart = getStartOfWeek(newDate);
    DateTime newEnd = getEndOfWeek(newDate);
    //
    // if (currentStart != newStart || currentEnd != newEnd) {
    //   currentStart = newStart;
    //   currentEnd = newEnd;
    //   callApi(newStart, newEnd);
    // }
  }

  Future<bool> timeTableDetail({
    required String timeTableId,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    showLoadingDialog();

    final response = await API.instance
        .post(endPoint: APIEndPoints.timetableDetails, params: {
      "time_table_id": timeTableId,
      "date": date,
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
