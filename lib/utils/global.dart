import 'dart:developer';

import 'package:atfb/export_files/export_files_must.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              // ElevatedButton(
              //   // key: keyCustom,
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: ColorStyle.primaryColor,
              //     elevation: 2,
              //     fixedSize: Size(50, 50),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              //   onPressed: positiveOnTap,
              //   child: Text(
              //     negativeButtonText,
              //     textAlign: TextAlign.center,
              //     style: CustomTextStyle.centraTextStyle(
              //         fontSize: 10,
              //         fontWeight: FontWeight.w600,
              //         color: Colors.white),
              //   ),
              // ),
              //   //   ElevatedButton(
              //   //   width: 90,
              //   //   height: 30,
              //   //   borderRadius: 7,
              //   //   text: '${tr().txt_ok}',
              //   //   elevation: 2,
              //   //   textStyle: TextStylesInter.textStyles_12
              //   //       .apply(fontWeightDelta: 2, color: Colors.white),
              //   //   colorBG: ColorStyle.theme08454C,
              //   //   onTap: (onTap == null)
              //   //       ? () {
              //   //     hideLoader();
              //   //   }
              //   //       : onTap,
              //   // );
              // ],

              // actions: [
              //   TextButton(
              //       onPressed: () {},
              //       child: Text(
              //         '$positiveButtonText',
              //         style: CustomTextStyle.centraTextStyle(
              //             fontSize: 10,
              //             fontWeight: FontWeight.w600,
              //             color: Colors.black),
              //       )),

              // ],
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
}
