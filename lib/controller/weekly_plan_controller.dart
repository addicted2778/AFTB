import 'dart:convert';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/model/dashboard_model.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';

import '../view/dashboard/weekly_plan/weekly_plan.dart';

class WeeklyPlanController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Meeting> totalMeetings = <Meeting>[].obs;
  var model = DashboardModel().obs;

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
}
