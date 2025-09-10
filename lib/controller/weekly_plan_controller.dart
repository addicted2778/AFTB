import 'dart:convert';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/model/dashboard_model.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';

import '../view/dashboard/weekly_plan/weekly_plan.dart';

class WeeklyPlanController extends GetxController {
  RxBool isLoading = false.obs;

  List<Meeting> totalMeetings = <Meeting>[];
  var model = DashboardModel().obs;

  weeklyData() async {
    DateTime today = DateTime.now();

    DateTime startOfWeek = today.subtract(Duration(days: today.weekday % 7));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    isLoading.value = true;

    final response =
        await API.instance.post(endPoint: APIEndPoints.timetable, params: {
      "start_date":
          "${startOfWeek.year}-${startOfWeek.month.toString().padLeft(2, '0')}-${startOfWeek.day.toString().padLeft(2, '0')}",
      "end_date":
          "${endOfWeek.year}-${endOfWeek.month.toString().padLeft(2, '0')}-${endOfWeek.day.toString().padLeft(2, '0')}",
    });

    isLoading.value = false;

    try {
      final data = jsonDecode(response.body);
      final status = data['statusCode'];
      if (status == 1) {
        model.value = DashboardModel.fromJson(data);

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

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 14);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    'starttime _getSource'.toString().logCustom();
    startTime.toString().logCustom();

    meetings.add(
      Meeting(
          'Conferences', startTime, endTime, const Color(0xFF0F8644), false),
    );
    'today.year'.logCustom();
    today.year.toString().logCustom();
    'today.month'.logCustom();
    today.month.toString().logCustom();
    'today.day'.logCustom();
    today.day.toString().logCustom();

    return meetings;
  }
}
