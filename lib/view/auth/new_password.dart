import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Styles/app_colors.dart';
import '../../components/app_buttons/full_width_button.dart';
import '../../components/custom_app_bar.dart';
import '../../controller/new_password_controller.dart';
import '../../routes/page_names.dart';
import '../../styles/app_textstyle.dart';
import '../../utils/custom_validation.dart';
import '../../utils/global.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  NewPasswordController controller = Get.put(NewPasswordController());

  final passwordKey = GlobalKey<FormState>();
  final confirmPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appbarTitle: 'New Password',
        isLeading: true,
        onTap: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            spacing(height: 10),
            Text(
              'Create a new password. Ensure it differs from previous ones for security',
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
                  Obx(
                    () => Form(
                      key: passwordKey,
                      child: TextFormField(
                        validator: (value) =>
                            CustomValidations.validateString(value ?? ''),
                        controller: controller.passwordController,
                        obscureText: controller.passwordObscurePassword.value,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline,
                              color: AppColor.primaryColor),
                          hintText: "Password",
                          hintStyle: TextStyle(color: AppColor.primaryColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.primaryColor, width: 1),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.passwordObscurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColor.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                controller.passwordObscurePassword.value =
                                    !controller.passwordObscurePassword.value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  spacing(height: 10),
                  Obx(
                    () => Form(
                      key: confirmPasswordKey,
                      child: TextFormField(
                        validator: (value) =>
                            CustomValidations.validateString(value ?? ''),
                        controller: controller.confirmPasswordController,
                        obscureText:
                            controller.confirmPasswordObscurePassword.value,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline,
                              color: AppColor.primaryColor),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: AppColor.primaryColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.primaryColor, width: 1),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.confirmPasswordObscurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColor.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                controller
                                        .confirmPasswordObscurePassword.value =
                                    !controller
                                        .confirmPasswordObscurePassword.value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  spacing(height: 10),
                  Obx(
                    () => FullWidthButton(
                        isLoading: controller.isLoading.value,
                        buttonText: 'Update Password',
                        buttonTap: () {
                          if (passwordKey.currentState!.validate() &&
                              confirmPasswordKey.currentState!.validate()) {
                            controller.updatePassword(email: Get.arguments[0]);
                          }
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
