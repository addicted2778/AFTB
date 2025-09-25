import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/controller/weekly_plan_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/model/time_table_detail_model.dart';
import 'package:atfb/utils/global.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:get/get.dart';

import '../../../components/event_bottom_sheet.dart';

class WeeklyPlan extends StatefulWidget {
  const WeeklyPlan({super.key});

  @override
  State<WeeklyPlan> createState() => _WeeklyPlanState();
}

class _WeeklyPlanState extends State<WeeklyPlan> {
  WeeklyPlanController controller = Get.put(WeeklyPlanController());

  late DateTime currentStart;
  late DateTime currentEnd;
  late DateTime baseDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baseDate = DateTime.now();
    currentStart = controller.getStartOfWeek(baseDate);
    currentEnd = controller.getEndOfWeek(baseDate);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.weeklyData(
            endDate: currentEnd,
            startDate: currentStart,
            isCallingFirstTime: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appbarTitle: 'Weekly Plan',
          isLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => (controller.isLoading.value)
              ? Container(
                  color: Colors.white,
                  height: Get.height,
                  width: Get.width,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                )
              : SfCalendar(
                  onTap: (CalendarTapDetails calendarTapDetails) async {
                    if (calendarTapDetails.appointments != null) {
                      final onTapData =
                          calendarTapDetails.appointments![0] as Meeting;
                      // calendarTapDetails.date
                      //     .toString()
                      //     .split(' ')
                      //     .first
                      //     .logCustom();
                      // onTapData.from.toString().logCustom();
                      // DateFormat("HH:mm:ss").format(onTapData.from).logCustom();

                      for (int a = 0;
                          a < controller.model.value.data!.timetable!.length;
                          a++) {
                        if (controller.model.value.data!.timetable![a].date ==
                            calendarTapDetails.date
                                .toString()
                                .split(' ')
                                .first) {
                          for (int b = 0;
                              b <
                                  controller.model.value.data!.timetable![a]
                                      .data!.length;
                              b++) {
                            if (controller.model.value.data!.timetable![a]
                                    .data![b].startTime
                                    .toString() ==
                                DateFormat("HH:mm:ss")
                                    .format(onTapData.from)
                                    .toString()) {
                              bool isData = await controller.timeTableDetail(
                                  timeTableId: controller.model.value.data!
                                      .timetable![a].data![b].id!
                                      .toString(),
                                  date: controller.model.value.data!
                                      .timetable![a].data![b].date!,
                                  startTime: controller.model.value.data!
                                      .timetable![a].data![b].startTime!,
                                  endTime: controller.model.value.data!
                                      .timetable![a].data![b].endTime!);

                              if (isData) {
                                showEventBottomSheet(context,
                                    timeTableDetail: controller
                                        .timeTableDetailModel
                                        .value
                                        .data!
                                        .timeTableDetail!);
                              }
                            }
                          }
                        }
                      }

                      /*showEventBottomSheet(context,
                          date: calendarTapDetails.date.toString(),
                          startTime: onTapData.from,
                          endTime: onTapData.to,
                          eventName: onTapData.eventName.toString());*/
                    } else {
                      'calendarTapDetails.appointments == null'.logCustom();
                    }

                    /* if (calendarTapDetails.appointments != null) {
                      int onTapIndex = 0;

                      final onTapMeeting =
                          calendarTapDetails.appointments![0] as Meeting;

                      for (int a = 0;
                          a < controller.model.value.data!.timetable!.length;
                          a++) {
                        for (int b = 0;
                            b <
                                controller.model.value.data!.timetable![a].data!
                                    .length;
                            b++) {
                          if (onTapMeeting.from.toString() ==
                              controller.model.value.data!.timetable![a]
                                  .data![b].startTime!
                                  .toString()) {
                            onTapIndex = b;
                            // break;
                          }
                        }
                      }
                      'ONTAPINDEX'.logCustom();
                      onTapIndex.toString().logCustom();
                      calendarTapDetails.date.toString().logCustom();
                      onTapMeeting.from.toString().logCustom();
                      onTapMeeting.to.toString().logCustom();
                    }*/
                  },
                  viewHeaderHeight: 80,
                  showCurrentTimeIndicator: true,
                  scheduleViewSettings: ScheduleViewSettings(
                    monthHeaderSettings: MonthHeaderSettings(
                      backgroundColor: Colors.white,
                      monthTextStyle: AppTextStyle.regularBlack(fontSize: 12),
                    ),
                  ),
                  timeSlotViewSettings: TimeSlotViewSettings(
                      numberOfDaysInView: 3,
                      dayFormat: 'E',
                      timeIntervalWidth: 80,
                      timeRulerSize: 60,
                      timeIntervalHeight: 50,
                      timeTextStyle: AppTextStyle.regularBlack(fontSize: 12),
                      startHour: 00,
                      endHour: 24,
                      timeFormat: 'h:mm a'),
                  cellBorderColor: Colors.white,
                  todayHighlightColor: AppColor.primaryColor,
                  // showTodayButton: false,
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
                  onViewChanged: (viewChangedDetails) {
                    if (viewChangedDetails.visibleDates[0]
                        .isBefore(currentStart)) {
                      currentStart = controller
                          .getStartOfWeek(viewChangedDetails.visibleDates[0]);

                      controller.weeklyData(
                          endDate: currentEnd, startDate: currentStart);
                    } else if (viewChangedDetails.visibleDates[2]
                        .isAfter(currentEnd)) {
                      currentEnd = controller
                          .getEndOfWeek(viewChangedDetails.visibleDates[2]);

                      controller.weeklyData(
                          endDate: currentEnd, startDate: currentStart);
                    }
                  },
                  dataSource: MeetingDataSource(controller.totalMeetings),
                  view: CalendarView.day,
                  monthViewSettings: const MonthViewSettings(
                    monthCellStyle: MonthCellStyle(
                      backgroundColor: Colors.white,
                    ),
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                  ),
                ),
        ));
  }

  void showEventBottomSheet(
    BuildContext context, {
    required TimeTableDetail timeTableDetail,
  }) {
    bool isGroupSession =
        (timeTableDetail.type == 'group_session') ? true : false;
    controller.isShowMembers.value = false;

    showModalBottomSheet(
        useSafeArea: true,
        elevation: 0,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => StatefulBuilder(
              builder: (context, setStateState) => ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height *
                      0.7, // max 70% of screen
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 20),
                        decoration: BoxDecoration(
                            color: (isGroupSession)
                                ? AppColor.hex(
                                    timeTableDetail.groupSession!.colorCode!)
                                : AppColor.hex(
                                    timeTableDetail.activity!.colorCode!),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (isGroupSession)
                                  ? timeTableDetail.groupSession!.name!
                                  : timeTableDetail.activity!.name!,
                              style: AppTextStyle.regularBlack(
                                fontSize: 16,
                              ),
                            ),
                            if (isGroupSession &&
                                !controller.isShowMembers.value)
                              InkWell(
                                onTap: () {
                                  controller.isShowMembers.value = true;
                                  setStateState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Avatars
                                    ...timeTableDetail.groupSession!.members!
                                        .take(2)
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key;
                                      String url = entry.value.profilePhoto ??
                                          AppImages.profile;

                                      return Transform.translate(
                                        offset:
                                            Offset(-20.0 * index, 0), // overlap
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.orange,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundImage: NetworkImage(url),
                                          ),
                                        ),
                                      );
                                    }),

                                    // Counter Circle
                                    // Counter Circle (only if more remain)
                                    if (timeTableDetail
                                            .groupSession!.members!.length >
                                        0)
                                      Transform.translate(
                                        offset: Offset(-20 * 3, 0),
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor:
                                              AppColor.primaryColor,
                                          child: CircleAvatar(
                                            radius: 18 - 2,
                                            backgroundColor: Colors.white,
                                            child: Text(
                                              "+${timeTableDetail.groupSession!.members!.length - 2}",
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontSize: 18 / 2.2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (!controller.isShowMembers.value) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              timeTableDetail.date!,
                              style: AppTextStyle.regularBlack(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${timeTableDetail.startTime.toString().formatTime()}-${timeTableDetail.endTime.toString().formatTime()}",
                              style: AppTextStyle.regularBlack(fontSize: 15),
                            ),
                          ),
                        ),
                        if (isGroupSession) ...[
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                timeTableDetail.groupSession!.location ?? '',
                                style: AppTextStyle.regularBlack(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (isGroupSession)
                                  ? "Description: ${timeTableDetail.groupSession!.description ?? ''}"
                                  : "Description: ${timeTableDetail.activity!.description ?? ''}",
                              style: AppTextStyle.regularBlack(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ] else
                        Expanded(
                            child: GridView.builder(
                                padding: const EdgeInsets.all(12),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 columns
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.85,
                                ),
                                itemCount: timeTableDetail
                                    .groupSession!.members!.length,
                                itemBuilder: (context, index) {
                                  final member = timeTableDetail
                                      .groupSession!.members![index];
                                  return Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Image.network(
                                              member.profilePhoto ??
                                                  'https://picsum.photos/200',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            color: Colors.orange,
                                            alignment: Alignment.center,
                                            child: Text(
                                              member.firstName! ?? '',
                                              style: AppTextStyle.mediumWhite(
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]);
                                })),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class MeetingDataSource extends CalendarDataSource {
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

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;

  DateTime from;

  DateTime to;

  Color background;

  bool isAllDay;
}
