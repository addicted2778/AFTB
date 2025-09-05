import 'package:atfb/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WeeklyPlan extends StatefulWidget {
  const WeeklyPlan({super.key});

  @override
  State<WeeklyPlan> createState() => _WeeklyPlanState();
}

class _WeeklyPlanState extends State<WeeklyPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appbarTitle: 'Weekly Schedule',
        isLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SfCalendar(
        backgroundColor: Colors.white,
      ),
    );
  }
}
