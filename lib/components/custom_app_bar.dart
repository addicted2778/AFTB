import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Styles/app_colors.dart';
import '../styles/app_textstyle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.appbarTitle,
    this.isLeading = true,
    this.isActionButton = false,
    this.onTap,
  });

  String? appbarTitle;
  bool isLeading;
  bool isActionButton;
  Function()? onTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark
      ),
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppColor.primaryColor, // Deep orange status bar background
          ),
          Expanded(child: Container(color: Colors.white)),
        ],
      ),
      centerTitle: true,
      leading: isLeading
          ? InkWell(
        onTap: () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.arrow_back, color: AppColor.primaryColor),
        ),
      )
          : null,
      title: Text(
        appbarTitle ?? '',
        style: AppTextStyle.mediumCustom(
          color: AppColor.primaryColor,
          fontSize: 20,
        ),
      ),);
      // leading: isLeading
      //     ? InkWell(
      //         onTap: () => Get.back(),
      //         child: Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: Icon(
      //             Icons.arrow_back,
      //             color: AppColor.primaryColor,
      //           ),
      //         ),
      //       )
      //     : null,
      // centerTitle: true,
      // title: Text(
      //   appbarTitle ?? '',
      //   style: AppTextStyle.mediumCustom(
      //     color: AppColor.primaryColor,
      //     fontSize: 20,
      //   ),
  }
}
