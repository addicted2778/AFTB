import 'package:atfb/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../Styles/app_colors.dart';
import '../../../controller/ViewFullDayController.dart';
import '../../../styles/app_textstyle.dart';
import '../../../utils/global.dart';

class ViewFullDay extends StatefulWidget {
  const ViewFullDay({super.key});

  @override
  State<ViewFullDay> createState() => _ViewFullDayState();
}

class _ViewFullDayState extends State<ViewFullDay> {
  ViewFullDayController controller = Get.put(ViewFullDayController());
  ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitData();
  }

  loadInitData() async {
    bool isApiDataLoad = await controller.dashBoard();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (isApiDataLoad) {
        if (itemScrollController.isAttached) {
          itemScrollController.scrollTo(
            index: controller.toScrollIndex.value,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<ViewFullDayController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    return Scaffold(
      appBar: CustomAppBar(
        appbarTitle: formattedDate,
        isLeading: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => (controller.isLoading.value ||
                controller.dashboardModel.value.data == null)
            ? Container(
                color: Colors.white,
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              )
            : (controller.dashboardModel.value.data!.timetable!.isEmpty)
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'You don’t have anything for today.',
                      style: AppTextStyle.semiBoldBlack(fontSize: 18),
                    ),
                  )
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(bottom: 20),
                    child: ScrollablePositionedList.separated(
                      itemScrollController: itemScrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.dashboardModel.value.data!
                          .timetable!.first.data!.length,
                      separatorBuilder: (context, index) => spacing(height: 20),
                      itemBuilder: (context, index) {
                        final data = controller.dashboardModel.value.data!
                            .timetable!.first.data![index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColor.hex(data.activity!.colorCode!),
                                width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  color:
                                      AppColor.hex(data.activity!.colorCode!),
                                  borderRadius: const BorderRadius.only(
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
                                padding:
                                    const EdgeInsets.only(left: 12, top: 12),
                                child: Text(
                                  "${data.startTime.toString().formatTime()}-${data.endTime.toString().formatTime()}",
                                  style: AppTextStyle.regularBlack(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 6, bottom: 12, right: 12),
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
                  ),
      ),
    );
  }
}
