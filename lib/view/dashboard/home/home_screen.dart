import 'package:atfb/components/app_text_filed.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../controller/home_screen_controller.dart';

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
      (_) {
        controller.siteSetting();
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
        appBar: CustomAppBar(appbarTitle: 'Today’s Activities',isLeading: false,),
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
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          data.activity!.name!,
                                          style: AppTextStyle.regularBlack(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 12, top: 12),
                                        child: Text(
                                          "10:00 AM – 11:00 AM",
                                          style: AppTextStyle.regularBlack(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
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
                        EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'View Full Day',
                      style: AppTextStyle.semiBoldWhite(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            spacing(height: 35)
          ],
        ));
  }
}
