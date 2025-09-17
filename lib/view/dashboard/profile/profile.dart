import 'package:atfb/components/app_web_view.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/const.dart';
import 'package:atfb/utils/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appbarTitle: 'Profile',
        isLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedBorder(
                    borderType: BorderType.Circle,
                    color: AppColor.primaryColor,
                    dashPattern: [6, 3], // dotted effect
                    padding: const EdgeInsets.all(4),
                    child: ClipOval(
                      child: (siteSettingData.value.profile!.profilePhoto ==
                              null)
                          ? Image.asset(
                              height: 100,
                              width: 100,
                              AppImages.profile,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      CircularProgressIndicator(
                                        color: AppColor.primaryColor,
                                      ),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              imageUrl:
                                  siteSettingData.value.profile!.profilePhoto!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  /*DottedBorder(
                  borderType: BorderType.Circle,
                  color: AppColor.primaryColor,
                  padding: EdgeInsets.all(5),
                  dashPattern: [6, 3], // length of dash and gap
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // color: Colors.white,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      height: 120,
                      width: 120,
                      child: (siteSettingData.value.profile!.profilePhoto ==
                              null)
                          ? Image.asset(
                              AppImages.profile,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: siteSettingData
                                  .value.profile!.profilePhoto!),

                      // child:,
                    ),
                  )),
              spacing(width: 20),*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        siteSettingData.value.profile!.firstName!,
                        style: AppTextStyle.mediumCustom(
                            fontSize: 19, color: AppColor.primaryColor),
                      ),
                      Text(
                        siteSettingData.value.profile!.patientId!,
                        style: AppTextStyle.regularCustom(
                          color: AppColor.grey808080,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            spacing(height: 20),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile & Security',
                  style: AppTextStyle.semiBoldPrimary(fontSize: 16),
                ),
              ),
            ),
            spacing(height: 10),
            Divider(
              color: AppColor.primaryColor.withOpacity(0.34),
              height: 1,
            ),
            commmonContainer(
                titleImage: AppImages.profile,
                titleText: 'My Profile',
                onTap: () {
                  Get.toNamed(PageNames.myProfile);
                }),
            Divider(
              color: AppColor.primaryColor.withOpacity(0.34),
              height: 1,
            ),
            commmonContainer(
                titleImage: AppImages.changePassword,
                titleText: 'Change Password',
                onTap: () {
                  Get.toNamed(PageNames.changePassword);
                }),
            // commmonContainer(
            //     titleImage: AppImages.membership,
            //     titleText: 'Membership',
            //     onTap: () {
            //       Get.toNamed(PageNames.membership);
            //     }),

            spacing(height: 10),

            InkWell(
              onTap: () {
                Get.toNamed(PageNames.membership);
              },
              child: Container(
                  width: Get.width,
                  // height: 80,
                  padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(color: AppColor.primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.membership,
                        height: 60,
                        width: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'My Membership',
                            // textAlign: TextAlign.center,
                            style: AppTextStyle.semiBoldWhite(fontSize: 16),
                          ),
                          Text(
                            'Mange your membership here',
                            style: AppTextStyle.regularWhite(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  )),
            ),

            spacing(height: 10),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Legal & Policy Information',
                  style: AppTextStyle.semiBoldPrimary(fontSize: 16),
                ),
              ),
            ),
            spacing(height: 10),
            Divider(
              color: AppColor.primaryColor.withOpacity(0.34),
              height: 1,
            ),
            commmonContainer(
                titleImage: AppImages.privacyPolicy,
                titleText: 'Privacy Policy',
                onTap: () {
                  Get.to(
                      CustomWebView(
                          appBarTitle: 'Privacy Policy',
                          url:
                              'https://kbdevs.com/atfb/privacy-policy?type=app'),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 600));
                }),
            Divider(
              color: AppColor.primaryColor.withOpacity(0.34),
              height: 1,
            ),
            commmonContainer(
                titleImage: AppImages.termsAndCondition,
                titleText: 'T&C',
                onTap: () {
                  Get.to(
                      CustomWebView(
                          appBarTitle: 'Terms And Conditions',
                          url:
                              'https://kbdevs.com/atfb/terms-and-conditions?type=app'),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 600));
                }),
            spacing(height: 10),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Manage Account',
                  style: AppTextStyle.semiBoldPrimary(fontSize: 16),
                ),
              ),
            ),
            spacing(height: 10),
            Divider(
              color: AppColor.primaryColor.withOpacity(0.34),
              height: 1,
            ),
            commmonContainer(
                titleImage: AppImages.changePassword,
                titleText: 'Logout',
                onTap: () {
                  customShowDailog('Are you sure, you want to logout?',
                      barrierDismissible: true,
                      positiveButtonText: 'Yes',
                      negativeButtonText: 'No',
                      isNegativeShown: true, positiveOnTap: () {
                    controller.logout();
                  }, neagtiveOnTap: () {
                    Navigator.pop(context);
                  });
                }),
            Divider(
              color: AppColor.primaryColor.withOpacity(0.34),
              height: 1,
            ),
            commmonContainer(
                titleImage: AppImages.deleteMyAccount,
                titleText: 'Delete My Account',
                onTap: () {
                  Get.toNamed(PageNames.deleteAccount);
                }),
            // Divider(
            //   color: AppColor.primaryColor.withOpacity(0.34),
            //   height: 1,
            // ),
            // spacing(height: 20),
            spacing(height: 40),
          ],
        ),
      ),
    );
  }

  Widget commmonContainer(
          {required String titleText,
          required String titleImage,
          required Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          /*decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: AppColor.primaryColor.withOpacity(0.34)))),*/
          child: Row(
            children: [
              Image.asset(
                titleImage,
                height: 26,
                width: 26,
                color: AppColor.primaryColor,
              ),
              spacing(width: 16),
              Expanded(
                child: Text(
                  titleText,
                  style: AppTextStyle.regularBlack(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      );
}
