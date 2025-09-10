import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../export_files/export_files_must.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      required this.appbarTitle,
      this.isLeading = true,
      this.isActionButton = false,
      this.onTap});

  String? appbarTitle;
  bool isLeading = false;
  bool isActionButton = false;
  Function()? onTap;

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.primaryColor,
        // statusBarIconBrightness: Brightness.light,
      ),
      leading: (isLeading)
          ? InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColor.primaryColor,
                  )),
            )
          : null,
      centerTitle: true,
      title: Text(
        appbarTitle ?? '',
        style: AppTextStyle.mediumCustom(
            color: AppColor.primaryColor, fontSize: 20),
      ),
      backgroundColor: Colors.white,
    );
  }
}
