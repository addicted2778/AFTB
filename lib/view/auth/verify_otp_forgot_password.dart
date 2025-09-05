import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../components/app_buttons/full_width_button.dart';
import '../../components/app_text_filed.dart';
import '../../components/custom_app_bar.dart';
import '../../controller/verify_otp_controller.dart';
import '../../utils/custom_validation.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  VerifyOtpController controller = Get.put(VerifyOtpController());
  final otpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        appbarTitle: 'Verify Otp',
        isLeading: true,
        onTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            spacing(height: 10),
            Text(
              'Please enter the OTP sent to ${Get.arguments[0].toString().substring(0, 3)}***@gmail.com',
              style: AppTextStyle.regularCustom(
                  fontSize: 16, color: AppColor.black1212OP60),
            ),
            spacing(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.primaryColor)),
              child: Column(
                children: [
                  Form(
                    key: otpKey,
                    child: Pinput(
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColor.primaryColor)),
                          height: 52,
                          width: 52),
                      pinAnimationType: PinAnimationType.fade,
                      onSubmitted: (value) {
                        if (otpKey.currentState!.validate()) {
                          controller.verifyOtp(email: Get.arguments[0]);
                        }
                      },
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.number,
                      controller: controller.otpTextfield,
                      validator: (value) =>
                          CustomValidations.validateOtp(value ?? ''),
                    ),
                  ),
                  spacing(height: 20),
                  Obx(
                    () => FullWidthButton(
                      buttonText: 'Verify Otp',
                      buttonTap: () {
                        if (otpKey.currentState!.validate()) {
                          controller.verifyOtp(email: Get.arguments[0]);
                        }
                      },
                      isLoading: controller.isLoading.value,
                    ),
                  )
                ],
              ),
            ),
            spacing(height: 20),
            Expanded(
              child: RichText(
                text: TextSpan(
                    text: 'Haven’t got the OTP yet? ',
                    style: AppTextStyle.regularCustom(
                      color: AppColor.grey606060,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            /*  Get.to(WebViewCustom(
                                                appBarTitle:
                                                    'Terms And Conditions',
                                                url: termsAndConditionUrl));*/
                          },
                        text: 'RESEND OTP',
                        style: AppTextStyle.semiBoldPrimary(
                          // decorationThickness: 3,
                          fontSize: 16,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
