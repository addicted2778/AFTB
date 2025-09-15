import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/view/dashboard/home/home_screen.dart';
import 'package:atfb/view/dashboard/profile/profile.dart';
import 'package:atfb/view/dashboard/weekly_plan/weekly_plan.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../utils/global.dart';

class AppBottomBar extends StatefulWidget {
  AppBottomBar({super.key, required this.selectedIndex});
  int selectedIndex = 1;
  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {

  iconBuilder(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon(index),
            color: Colors.black,
            size: 28,
          ),
          spacing(height: 2),
          Text(
            label(index),
            style: AppTextStyle.regularBlack(fontSize: 13),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: openPage(widget.selectedIndex),
      bottomNavigationBar: Container(
        padding: EdgeInsetsGeometry.only(left: 16,right: 16 ,bottom: 20),
        height: 88,
        decoration: BoxDecoration(color: AppColor.lightPrimaryOP43),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (widget.selectedIndex == 0)
                    ? Expanded(child: SizedBox())
                    : Expanded(
                        child: iconBuilder(0),
                      ),
                (widget.selectedIndex == 1)
                    ? Expanded(child: SizedBox())
                    : Expanded(
                        child: iconBuilder(1),
                      ),
                (widget.selectedIndex == 2)
                    ? Expanded(child: SizedBox())
                    : Expanded(
                        child: iconBuilder(2),
                      ),
              ],
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (widget.selectedIndex == 0)
                    ? Expanded(child: SizedBox())
                    : Expanded(
                  child: iconBuilder(0),
                ),
                (widget.selectedIndex == 1)
                    ? Expanded(child: SizedBox())
                    : Expanded(
                  child: iconBuilder(1),
                ),
                (widget.selectedIndex == 2)
                    ? Expanded(child: SizedBox())
                    : Expanded(
                  child: iconBuilder(2),
                ),
              ],
            ),*/
            if (widget.selectedIndex == 0)
              Positioned(
                  top: -35,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColor.lightPrimary, width: 5)
                        // borderRadius: BorderRadius.circular(100)
                        ),
                    height: 80,
                    width: 80,
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100)
                      ),
                      child: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )),
            if (widget.selectedIndex == 1)
              Positioned(
                  top: -35,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColor.lightPrimary, width: 5)
                        // borderRadius: BorderRadius.circular(100)
                        ),
                    height: 80,
                    width: 80,
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100)
                      ),
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  )),
            if (widget.selectedIndex == 2)
              Positioned(
                  top: -35,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColor.lightPrimary, width: 5)
                        // borderRadius: BorderRadius.circular(100)
                        ),
                    height: 80,
                    width: 80,
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  openPage(int index) {
    switch (index) {
      case 0:
        return WeeklyPlan();
      case 1:
        return HomeScreen();
      case 2:
        return Profile();
    }
  }

  icon(int index) {
    switch (index) {
      case 0:
        return Icons.calendar_month_outlined;
      case 1:
        return Icons.home_outlined;
      case 2:
        return Icons.person_outline;
    }
  }

  label(int index) {
    switch (index) {
      case 0:
        return "Week Plan";
      case 1:
        return "Home";
      case 2:
        return "Account";
    }
  }
}
