import 'package:atfb/components/app_buttons/full_width_button.dart';
import 'package:atfb/components/app_text_filed.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/controller/forgot_password_controller.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/custom_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/global.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  final emailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        appbarTitle: 'Forgot Password',
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
              'Please enter your Email ID to reset the password',
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
                    key: emailKey,
                    child: AppTextFiled(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColor.primaryColor,
                      ),
                      validator: (value) =>
                          CustomValidations.validateEmail(value ?? ''),
                      controller: controller.emailTextfield,
                      hintText: 'Email',
                    ),
                  ),
                  spacing(height: 20),
                  Obx(
                    () => FullWidthButton(
                      buttonText: 'Submit',
                      buttonTap: () {
                        if (emailKey.currentState!.validate()) {
                          controller.forgotPassword();
                        }
                      },
                      isLoading: controller.isLoading.value,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
