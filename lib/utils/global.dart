import 'dart:developer';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

spacing({double height = 0.0, double width = 0.0}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

customShowDailog(String? description,
    {required bool barrierDismissible,
    required String positiveButtonText,
    required String negativeButtonText,
    required bool isNegativeShown,
    required Function() positiveOnTap,
    String title = 'AFTB',
    required Function() neagtiveOnTap}) {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: Get.context!,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: AlertDialog(
            backgroundColor: Colors.white,
            title: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.white,
                width: 2,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.mediumBlack(
                      fontSize: 21,
                    ),
                    // style: TextStylesInter.textStyles_16.apply(
                    //   color: Colors.black,
                    //   fontWeightDelta: 1,
                    // ),
                  ),
                ],
              ),
            ),
            alignment: Alignment.center,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              description!,
              style: AppTextStyle.mediumBlack(
                fontSize: 15,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: positiveOnTap,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.primaryColor,
                            ),
                            alignment: Alignment.center,
                            // width: double.infinity,
                            // width: 100,
                            height: 45,
                            child: Text(
                              positiveButtonText,
                              style: AppTextStyle.mediumWhite(
                                fontSize: 18,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    if (isNegativeShown)
                      Expanded(
                        child: InkWell(
                          onTap: neagtiveOnTap,
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                              ),
                              // width: 100,
                              height: 45,
                              child: Text(
                                negativeButtonText,
                                style: AppTextStyle.mediumWhite(
                                  fontSize: 18,
                                ),
                              )),
                        ),
                      ),
                  ],
                ),
              )
            ]),
      );
    },
  );
}

extension StringCustom on String {
  logCustom() {
    if (kDebugMode) print(this);
  }

  showSnackBar() async {
    Get.closeAllSnackbars();
    return Get.snackbar('Alert', this,
        backgroundColor: AppColor.primaryColor, colorText: Colors.white);
  }

  formatTime() {
    DateTime dateTime = DateFormat("HH:mm:ss").parse(this);

    // Format into 12-hour with AM/PM
    String formattedTime = DateFormat("h:mm a").format(dateTime);

    return formattedTime;
  }
}

uploadBottomSheet({
  required BuildContext context,
  Function()? takePhoto,
  Function()? uploadGallery,
  String labelText = 'Upload Profile Picture',
}) {
  return showModalBottomSheet(
    isScrollControlled: false,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(17), topRight: Radius.circular(17))),
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17), topRight: Radius.circular(17))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            spacing(
              height: 20,
            ),
            Text(
              labelText.tr,
              style: AppTextStyle.boldBlack(
                fontSize: 20,
              ),
            ),
            spacing(
              height: 16,
            ),
            Divider(
              color: AppColor.primaryColor,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: takePhoto,
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    spacing(
                      width: 20,
                    ),
                    Text('Take photo'.tr,
                        style: AppTextStyle.mediumBlack(
                          fontSize: 18,
                        ))
                  ],
                ),
              ),
            ),
            Divider(
              color: AppColor.primaryColor,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: uploadGallery,
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.photo,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    spacing(
                      width: 20,
                    ),
                    Text(
                      'Upload from gallery'.tr,
                      style: AppTextStyle.mediumBlack(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            spacing(height: 40),
          ],
        ),
      ),
    ),
  );
}

pickImage(
    {required ImageSource imageSource, required BuildContext context}) async {
  var pickedImage = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear);
  if (pickedImage != null) {
    return pickedImage.path;
  }
}
