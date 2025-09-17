import 'dart:convert';

import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/dashboard_model.dart';
import '../services/api_services.dart';

class ViewFullDayController extends GetxController {
  RxBool isLoading = false.obs;

  RxInt toScrollIndex = 0.obs;

  var dashboardModel = DashboardModel().obs;

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
            if (a > 2) {
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
}
