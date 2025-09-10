import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/controller/weekly_plan_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
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
        backgroundColor: AppColor.primaryColor,
        body: Column(
          children: [
            spacing(height: 30),
            CustomAppBar(appbarTitle: 'Weekly Plan',isLeading: false,),
            Obx(
                  () => (controller.isLoading.value)
                  ? Expanded(
                    child: Container(
                      color: Colors.white,
                                    height: Get.height,
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                                    ),
                                  ),
                  )
                  : Expanded(child: SfCalendar(
                    viewHeaderHeight: 80,
                    showCurrentTimeIndicator: false,
                    scheduleViewSettings: ScheduleViewSettings(
                        monthHeaderSettings: MonthHeaderSettings(
                          backgroundColor: Colors.white,
                          monthTextStyle: AppTextStyle.regularBlack(fontSize: 12),
                        ),
                        weekHeaderSettings:
                        WeekHeaderSettings(backgroundColor: Colors.red)),
                    timeSlotViewSettings: TimeSlotViewSettings(
                        numberOfDaysInView: 3,
                        dayFormat: 'E',
                        timeTextStyle: AppTextStyle.regularBlack(fontSize: 12),
                        startHour: 00,
                        endHour: 24,
                        timeFormat: 'h:mm a'),
                    cellBorderColor: Colors.white,
                    todayHighlightColor: AppColor.primaryColor,
                    showTodayButton: false,
                    viewNavigationMode: ViewNavigationMode.snap,
                    todayTextStyle: AppTextStyle.mediumCustom(
                        color: Colors.white, fontSize: 15),
                    viewHeaderStyle: ViewHeaderStyle(
                        backgroundColor: Colors.white,
                        dayTextStyle: AppTextStyle.regularCustom(
                            color: AppColor.grey121212.withOpacity(0.60),
                            fontSize: 15),
                        dateTextStyle: AppTextStyle.regularBlack(fontSize: 15)),
                    weekNumberStyle: WeekNumberStyle(
                        backgroundColor: Colors.white,
                        textStyle: AppTextStyle.mediumCustom(
                            color: AppColor.primaryColor, fontSize: 15)),
                    allowViewNavigation: true,
                    backgroundColor: Colors.white,
                    dataSource: MeetingDataSource(controller.totalMeetings),
                    view: CalendarView.day,
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                    ),
                  ),)
            )
          ],
        ));
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
