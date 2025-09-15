import 'package:atfb/components/app_buttons/full_width_button.dart';
import 'package:atfb/components/app_text_filed.dart';
import 'package:atfb/components/app_web_view.dart';
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
  final LoginScreenController controller = Get.put(LoginScreenController());

  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  // Scroll + focus handling
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // Keys for ensureVisible
  final GlobalKey _emailFieldKey = GlobalKey();
  final GlobalKey _passwordFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // When focus changes, scroll the focused field into view
    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        _scrollIntoView(_emailFieldKey);
      }
    });

    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        _scrollIntoView(_passwordFieldKey);
      }
    });
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollIntoView(GlobalKey key) async {
    // Slight delay to let keyboard open & layout settle
    await Future.delayed(const Duration(milliseconds: 250));
    final ctx = key.currentContext;
    if (ctx != null) {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment:
            0.25, // tweak this to change how the widget positions in viewport
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top logo area
                        Container(
                          height: Get.height * 0.40,
                          width: Get.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Image.asset(AppImages.logo),
                        ),

                        Text(
                          'Login',
                          style: AppTextStyle.semiBoldPrimary(fontSize: 28),
                        ),
                        spacing(height: 18),

                        // Card container that holds the forms & button
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.primaryColor),
                          ),
                          child: Column(
                            children: [
                              Container(
                                key: _emailFieldKey,
                                child: Form(
                                  key: emailKey,
                                  child: AppTextFiled(
                                    focusNode:
                                        _emailFocus, // <--- pass focusNode to your custom field
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        CustomValidations.validateEmail(
                                            value ?? ''),
                                    controller: controller.emailController,
                                    prefixIcon: Icon(Icons.email_outlined,
                                        color: AppColor.primaryColor),
                                    hintText: 'Email',
                                  ),
                                ),
                              ),

                              spacing(height: 10),

                              // Password field
                              Obx(
                                () => Container(
                                  key: _passwordFieldKey,
                                  child: Form(
                                    key: passwordKey,
                                    child: AppTextFiled(
                                      focusNode: _passwordFocus,
                                      validator: (value) =>
                                          CustomValidations.validateString(
                                              value ?? ''),
                                      controller: controller.passwordController,
                                      hintText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock_outlined,
                                        color: AppColor.primaryColor,
                                      ),
                                      suffixIcon: Obx(() {
                                        return IconButton(
                                          icon: Icon(
                                            controller.obscurePassword.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: AppColor.primaryColor,
                                          ),
                                          onPressed: () {
                                            controller.obscurePassword.value =
                                                !controller
                                                    .obscurePassword.value;
                                          },
                                        );
                                      }),
                                      obscureText:
                                          controller.obscurePassword.value,
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
                                      color: AppColor.primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),

                              spacing(height: 10),

                              // Login button
                              Obx(
                                () => FullWidthButton(
                                  isLoading: controller.isLoading.value,
                                  buttonText: 'Login',
                                  buttonTap: () {
                                    if (controller.checkBoxEnable.value) {
                                      if (emailKey.currentState!.validate() &&
                                          passwordKey.currentState!
                                              .validate()) {
                                        controller.userLogin();
                                      }
                                    } else {
                                      'Please accept terms and conditions and privacy policy'
                                          .showSnackBar();
                                    }
                                  },
                                ),
                              ),

                              // Terms checkbox + rich text
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
                                          text:
                                              'By registering, you accept our ',
                                          style: AppTextStyle.regularCustom(
                                            color: AppColor.grey606060,
                                            fontSize: 12,
                                          ),
                                          children: [
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Get.to(
                                                      CustomWebView(
                                                        appBarTitle:
                                                            'Terms And Conditions',
                                                        url:
                                                            'https://kbdevs.com/atfb/terms-and-conditions?type=app',
                                                      ),
                                                      transition:
                                                          Transition.cupertino,
                                                      duration: Duration(
                                                          milliseconds: 600));
                                                },
                                              text: 'Terms and Conditions',
                                              style: AppTextStyle.boldPrimary(
                                                fontSize: 12,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' and',
                                              style: AppTextStyle.regularCustom(
                                                color: AppColor.grey606060,
                                                fontSize: 12,
                                              ),
                                            ),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Get.to(
                                                      CustomWebView(
                                                        appBarTitle:
                                                            'Privacy Policy',
                                                        url:
                                                            'https://kbdevs.com/atfb/privacy-policy?type=app',
                                                      ),
                                                      transition:
                                                          Transition.cupertino,
                                                      duration: const Duration(
                                                          milliseconds: 600));
                                                },
                                              text: ' Privacy Policy',
                                              style: AppTextStyle.boldPrimary(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        spacing(height: 18),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
