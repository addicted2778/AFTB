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
      // clipBehavior: Clip.none,
      backgroundColor: Colors.white,
      leading: isLeading
          ? InkWell(
        onTap: () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
        ),
      )
          : null,
      centerTitle: true,
      title: Text(
        appbarTitle ?? '',
        style: AppTextStyle.mediumCustom(
          color: AppColor.primaryColor,
          fontSize: 20,
        ),
      ),
    );
  }
}
