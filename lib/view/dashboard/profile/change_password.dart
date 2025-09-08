import 'package:atfb/components/app_buttons/full_width_button.dart';
import 'package:atfb/components/app_text_filed.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/export_files/export_files_must.dart' hide AppColor;
import 'package:atfb/utils/custom_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Styles/app_colors.dart';
import '../../../controller/change_password_controller.dart';
import '../../../utils/global.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ChangePasswordController controller = Get.put(ChangePasswordController());

  final currentPasswordKey = GlobalKey<FormState>();
  final newPasswordKey = GlobalKey<FormState>();
  final confirmPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(appbarTitle: 'Change Password'),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set a new password for your account'.tr,
              style: AppTextStyle.mediumBlack(fontSize: 16),
            ),
            spacing(height: Get.height * 0.02),
            Form(
              key: currentPasswordKey,
              child: AppTextFiled(
                prefixIcon:
                    Icon(Icons.lock_outline, color: AppColor.primaryColor),
                validator: (value) =>
                    CustomValidations.validateString(value ?? ''),
                obscureText: controller.obscureCurrentPassword.value,
                controller: controller.currentPasswordController,
                hintText: 'Old Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureCurrentPassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.obscureCurrentPassword.value =
                          !controller.obscureCurrentPassword.value;
                    });
                  },
                ),
              ),
            ),
            spacing(height: 30),
            Form(
              key: newPasswordKey,
              child: AppTextFiled(
                prefixIcon:
                    Icon(Icons.lock_outline, color: AppColor.primaryColor),
                validator: (value) =>
                    CustomValidations.validateString(value ?? ''),
                obscureText: controller.obscureNewPassword.value,
                controller: controller.newPasswordController,
                hintText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureNewPassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.obscureNewPassword.value =
                          !controller.obscureNewPassword.value;
                    });
                  },
                ),
              ),
            ),
            spacing(height: 30),
            Form(
              key: confirmPasswordKey,
              child: AppTextFiled(
                prefixIcon:
                    Icon(Icons.lock_outline, color: AppColor.primaryColor),
                validator: (value) =>
                    CustomValidations.validateString(value ?? ''),
                obscureText: controller.obscureConfirmPassword.value,
                controller: controller.confirmPasswordController,
                hintText: 'Confirm New Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureConfirmPassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.obscureConfirmPassword.value =
                          !controller.obscureConfirmPassword.value;
                    });
                  },
                ),
              ),
            ),
            spacing(height: 30),
            Obx(
              () => FullWidthButton(
                buttonText: 'Submit',
                isLoading: controller.isLoading.value,
                buttonTap: () {
                  if (currentPasswordKey.currentState!.validate() &&
                      newPasswordKey.currentState!.validate() &&
                      confirmPasswordKey.currentState!.validate()) {
                    controller.changePassword();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
