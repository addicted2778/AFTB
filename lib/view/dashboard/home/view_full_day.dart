import 'package:atfb/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.dashBoard();
      },
    );
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
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller
                    .dashboardModel.value.data!.timetable!.first.data!.length,
                separatorBuilder: (context, index) => spacing(height: 20),
                itemBuilder: (context, index) {
                  final data = controller
                      .dashboardModel.value.data!.timetable!.first.data![index];

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
                            color: AppColor.hex(data.activity!.colorCode!),
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
                          padding: EdgeInsets.only(left: 12, top: 12),
                          child: Text(
                            "10:00 AM – 11:00 AM",
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
    );
  }
}
