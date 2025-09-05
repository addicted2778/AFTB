import 'dart:convert';

import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/dashboard_model.dart';
import '../services/api_services.dart';

class ViewFullDayController extends GetxController {
  RxBool isLoading = false.obs;

  var dashboardModel = DashboardModel().obs;

  dashBoard() async {
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
      } else {
        data['message'].toString().showSnackBar();
      }
    } catch (e, stackTrace) {
      e.toString().logCustom();
      stackTrace.toString().logCustom();
    }
  }
}
