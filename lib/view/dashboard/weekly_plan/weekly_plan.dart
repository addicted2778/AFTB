import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/controller/weekly_plan_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:get/get.dart';

class WeeklyPlan extends StatefulWidget {
  const WeeklyPlan({super.key});

  @override
  State<WeeklyPlan> createState() => _WeeklyPlanState();
}

class _WeeklyPlanState extends State<WeeklyPlan> {
  WeeklyPlanController controller = Get.put(WeeklyPlanController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.weeklyData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appbarTitle: 'Weekly Schedule',
          isLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => (controller.isLoading.value)
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                )
              : SfCalendar(
                  backgroundColor: Colors.white,
                ),
        ));
  }
}
