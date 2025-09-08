import 'package:atfb/export_files/export_files_must.dart';
import 'package:get/get.dart';

class WeeklyPlanController extends GetxController {
  RxBool isLoading = false.obs;

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
  }
}
