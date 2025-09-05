import 'package:atfb/components/app_buttons/full_width_button.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/styles/app_images.dart';
import 'package:atfb/utils/custom_validation.dart';
import 'package:atfb/utils/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenController controller = Get.put(LoginScreenController());

  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.40,
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Image.asset(AppImages.logo),
                ),
                Text(
                  'Login',
                  style: AppTextStyle.semiBoldPrimary(fontSize: 28),
                ),
                spacing(height: 18),
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
                        child: TextFormField(
                          validator: (value) =>
                              CustomValidations.validateEmail(value ?? ''),
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined,
                                color: AppColor.primaryColor),
                            hintText: "Email",
                            hintStyle: TextStyle(color: AppColor.primaryColor),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.primaryColor, width: 1),
                            ),
                          ),
                        ),
                      ),
                      spacing(height: 10),
                      Form(
                        key: passwordKey,
                        child: TextFormField(
                          validator: (value) =>
                              CustomValidations.validateString(value ?? ''),
                          controller: controller.passwordController,
                          // obscureText: _obscurePassword,
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
                                controller.obscurePassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColor.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  controller.obscurePassword.value =
                                      !controller.obscurePassword.value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      spacing(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(PageNames.forgotPassword);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyle.regularCustom(
                                color: AppColor.primaryColor, fontSize: 14),
                          ),
                        ),
                      ),
                      spacing(height: 10),
                      Obx(
                        () => FullWidthButton(
                            isLoading: controller.isLoading.value,
                            buttonText: 'Login',
                            buttonTap: () {
                              if (emailKey.currentState!.validate() &&
                                  passwordKey.currentState!.validate()) {
                                controller.userLogin();
                              }
                            }),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: Checkbox(
                                activeColor: AppColor.primaryColor,
                                value: controller.checkBoxEnable.value,
                                onChanged: (value) {
                                  controller.checkBoxEnable.value =
                                      !controller.checkBoxEnable.value;
                                },
                                checkColor: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                    text: 'By registering, you accept our ',
                                    style: AppTextStyle.regularCustom(
                                      color: AppColor.grey606060,
                                      fontSize: 12,
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
                                        text: 'Terms and Conditions',
                                        style: AppTextStyle.boldPrimary(
                                          // decorationThickness: 3,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                        text: ' and',
                                        style: AppTextStyle.regularCustom(
                                          color: AppColor.grey606060,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Get.to(WebViewCustom(
                                            //     appBarTitle: 'Privacy Policy',
                                            //     url: privacyPolicyUrl));
                                          },
                                        text: ' Privacy Policy',
                                        style: AppTextStyle.boldPrimary(
                                          // decorationThickness: 3,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
