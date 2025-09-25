import 'package:atfb/components/app_text_filed.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/model/dashboard_model.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../model/time_table_detail_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await controller.siteSetting();
        controller.dashBoard();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          appbarTitle: 'Today’s Activities',
          isLeading: false,
        ),
        body: Column(
          children: [
            Text(
              formattedDate,
              style: AppTextStyle.mediumBlack(fontSize: 20),
            ),
            spacing(height: 15),
            Obx(
              () => (controller.isLoading.value ||
                      controller.dashboardModel.value.data == null)
                  ? Expanded(
                      child: Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ))
                  : (controller.dashboardModel.value.data!.timetable!.isEmpty)
                      ? Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'You don’t have anything for today.',
                              style: AppTextStyle.semiBoldBlack(fontSize: 18),
                            ),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                              child: Obx(
                            () => ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.dashboardModel.value.data!
                                  .timetable!.first.data!.length,
                              separatorBuilder: (context, index) =>
                                  spacing(height: 20),
                              itemBuilder: (context, index) {
                                final data = controller.dashboardModel.value
                                    .data!.timetable!.first.data![index];
                                final currentDate = DateTime.now();

                                final start = DateTime(
                                  currentDate.year,
                                  currentDate.month,
                                  currentDate.day,
                                  int.parse(controller
                                      .dashboardModel
                                      .value
                                      .data!
                                      .timetable!
                                      .first
                                      .data![index]
                                      .startTime
                                      .toString()
                                      .split(':')[0]),
                                  int.parse(controller
                                      .dashboardModel
                                      .value
                                      .data!
                                      .timetable!
                                      .first
                                      .data![index]
                                      .startTime
                                      .toString()
                                      .split(':')[1]),
                                );

                                final end = DateTime(
                                  currentDate.year,
                                  currentDate.month,
                                  currentDate.day,
                                  int.parse(controller
                                      .dashboardModel
                                      .value
                                      .data!
                                      .timetable!
                                      .first
                                      .data![index]
                                      .endTime
                                      .toString()
                                      .split(':')[0]),
                                  int.parse(controller
                                      .dashboardModel
                                      .value
                                      .data!
                                      .timetable!
                                      .first
                                      .data![index]
                                      .endTime
                                      .toString()
                                      .split(':')[1]),
                                );

                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppColor.hex(
                                            data.activity!.colorCode!),
                                        width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: AppColor.hex(
                                                data.activity!.colorCode!),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.activity!.name!,
                                                style:
                                                    AppTextStyle.regularBlack(
                                                  fontSize: 19,
                                                ),
                                              ),
                                              if (currentDate.isAfter(start) &&
                                                  currentDate.isBefore(end))
                                                Image.asset(
                                                  AppImages.live,
                                                  height: 30,
                                                  width: 30,
                                                )
                                            ],
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${data.startTime.toString().formatTime()}-${data.endTime.toString().formatTime()}",
                                                style:
                                                    AppTextStyle.regularBlack(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              if (data.type.toString() ==
                                                  'group_session')
                                                InkWell(
                                                  onTap: () async {
                                                    bool isData =
                                                        await controller
                                                            .timeTableDetail(
                                                                timeTableId: data
                                                                    .id!
                                                                    .toString(),
                                                                startTime: data
                                                                    .activity!
                                                                    .startTime!,
                                                                endTime: data
                                                                    .activity!
                                                                    .endTime!);

                                                    if (isData) {
                                                      showEventBottomSheet(
                                                          context,
                                                          timeTableDetail: controller
                                                              .timeTableDetailModel
                                                              .value
                                                              .data!
                                                              .timeTableDetail!);
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      // Avatars
                                                      ...data.activity!.members!
                                                          .take(2)
                                                          .toList()
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                        int index = entry.key;
                                                        String url = entry.value
                                                                .profilePhoto ??
                                                            AppImages.profile;

                                                        return Transform
                                                            .translate(
                                                          offset: Offset(
                                                              -20.0 * index,
                                                              0), // overlap
                                                          child: CircleAvatar(
                                                            radius: 18,
                                                            backgroundColor:
                                                                Colors.orange,
                                                            child: CircleAvatar(
                                                              radius: 18,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      url),
                                                            ),
                                                          ),
                                                        );
                                                      }),

                                                      // Counter Circle
                                                      // Counter Circle (only if more remain)
                                                      if (data.activity!
                                                              .members!.length >
                                                          0)
                                                        Transform.translate(
                                                          offset: const Offset(
                                                              -20 * 3, 0),
                                                          child: CircleAvatar(
                                                            radius: 18,
                                                            backgroundColor:
                                                                AppColor
                                                                    .primaryColor,
                                                            child: CircleAvatar(
                                                              radius: 18 - 2,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Text(
                                                                "+${data.activity!.members!.length - 2}",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColor
                                                                      .primaryColor,
                                                                  fontSize:
                                                                      18 / 2.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12,
                                            top: 6,
                                            bottom: 12,
                                            right: 12),
                                        child: Text(
                                          data.activity!.name!,
                                          style: AppTextStyle.regularBlack(
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )),
                        ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => Get.toNamed(PageNames.viewFullDay),
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'View Full Day',
                      style: AppTextStyle.semiBoldWhite(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            spacing(height: 40)
          ],
        ));
  }

  void showEventBottomSheet(
    BuildContext context, {
    required TimeTableDetail timeTableDetail,
  }) {
    bool isGroupSession =
        (timeTableDetail.type == 'group_session') ? true : false;

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
                            Row(
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
                                    offset: Offset(-20.0 * index, 0), // overlap
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
                                      backgroundColor: AppColor.primaryColor,
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
                          ],
                        ),
                      ),
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
                              itemCount:
                                  timeTableDetail.groupSession!.members!.length,
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
