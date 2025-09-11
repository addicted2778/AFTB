import 'dart:io';

import 'package:atfb/components/app_buttons/full_width_button.dart';
import 'package:atfb/components/app_text_filed.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/controller/edit_profile_controller.dart';
import 'package:atfb/utils/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../export_files/export_files_must.dart';
import '../../../utils/const.dart';
import '../../../utils/custom_validation.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  EditProfileController controller = Get.put(EditProfileController());

  final firstNKey = GlobalKey<FormState>();
  final lastNKey = GlobalKey<FormState>();
  final phoneNKey = GlobalKey<FormState>();
  final ePhoneNKey = GlobalKey<FormState>();
  final dobNKey = GlobalKey<FormState>();
  final addressNKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.firstNController.text =
            siteSettingData.value.profile!.firstName ?? '';
        controller.lastNController.text =
            siteSettingData.value.profile!.lastName ?? '';
        controller.dobController.text =
            siteSettingData.value.profile!.dateOfBirth ?? '';
        controller.phoneNController.text =
            siteSettingData.value.profile!.phoneNumber ?? '';
        controller.ePhoneNController.text =
            siteSettingData.value.profile!.emergencyPhoneNumber ?? '';
        controller.addressController.text =
            siteSettingData.value.profile!.address ?? '';
        controller.emailController.text =
            siteSettingData.value.profile!.email ?? '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          spacing(height: 30),
          CustomAppBar(
            appbarTitle: 'Edit Profile',
            isLeading: true,
            onTap: () => Get.back(),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      spacing(height: 20),
                      Obx(
                        () => Center(
                          child: Container(
                            // margin: EdgeInsets.only(right: 30),
                            width: 110,
                            height: 110,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.primaryColor, width: 3),
                                shape: BoxShape.circle),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: (controller.imagePath.value.isEmpty)
                                        ? (siteSettingData.value.profile!
                                                .profilePhoto!.isNotEmpty)
                                            ? CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                height: 110,
                                                width: 110,
                                                imageUrl: siteSettingData.value
                                                    .profile!.profilePhoto!)
                                            : Image.asset(
                                                AppImages.logo,
                                                height: 110,
                                                width: 110,
                                                fit: BoxFit.cover,
                                              )
                                        : Image.file(
                                            fit: BoxFit.cover,
                                            height: 110,
                                            width: 110,
                                            File(controller.imagePath.value))),
                                Positioned(
                                    right: -5,
                                    bottom: -2,
                                    child: InkWell(
                                      onTap: () async {
                                        await uploadBottomSheet(
                                          labelText:
                                              'Upload Profile Picture'.tr,
                                          uploadGallery: () async {
                                            Navigator.pop(context);
                                            final selectedImage =
                                                await pickImage(
                                                    imageSource:
                                                        ImageSource.gallery,
                                                    context: context);

                                            if (selectedImage != '') {
                                              controller.imagePath.value =
                                                  selectedImage;
                                            }
                                          },
                                          takePhoto: () async {
                                            Navigator.pop(context);
                                            final selectedImage =
                                                await pickImage(
                                                    imageSource:
                                                        ImageSource.camera,
                                                    context: context);

                                            if (selectedImage != null) {
                                              controller.imagePath.value =
                                                  selectedImage;
                                            }
                                          },
                                          context: context,
                                        );
                                      },
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.camera_alt_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      spacing(height: 20),
                      Form(
                        key: firstNKey,
                        child: AppTextFiled(
                          validator: (value) =>
                              CustomValidations.validateString(value ?? ''),
                          controller: controller.firstNController,
                          prefixIcon:
                              Icon(Icons.textsms, color: AppColor.primaryColor),
                          hintText: 'First Name',
                        ),
                      ),
                      spacing(height: 30),
                      Form(
                        key: lastNKey,
                        child: AppTextFiled(
                          validator: (value) =>
                              CustomValidations.validateString(value ?? ''),
                          controller: controller.lastNController,
                          prefixIcon:
                              Icon(Icons.textsms, color: AppColor.primaryColor),
                          hintText: 'Last Name',
                        ),
                      ),
                      spacing(height: 30),
                      AppTextFiled(
                        readOnly: true,
                        validator: (value) =>
                            CustomValidations.validateEmail(value ?? ''),
                        controller: controller.emailController,
                        prefixIcon: Icon(Icons.email_outlined,
                            color: AppColor.primaryColor),
                        hintText: 'Email',
                      ),
                      spacing(height: 30),
                      Form(
                        key: phoneNKey,
                        child: AppTextFiled(
                          keyboardType: TextInputType.number,
                          maxlength: 10,
                          validator: (value) =>
                              CustomValidations.validateMobile(value ?? ''),
                          controller: controller.phoneNController,
                          prefixIcon:
                              Icon(Icons.phone, color: AppColor.primaryColor),
                          hintText: 'Phone Number',
                        ),
                      ),
                      spacing(height: 30),
                      Form(
                        key: ePhoneNKey,
                        child: AppTextFiled(
                          maxlength: 10,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              CustomValidations.validateMobile(value ?? ''),
                          controller: controller.ePhoneNController,
                          prefixIcon:
                              Icon(Icons.phone, color: AppColor.primaryColor),
                          hintText: 'Emergency Phone Number',
                        ),
                      ),
                      spacing(height: 30),
                      Form(
                        key: dobNKey,
                        child: AppTextFiled(
                          readOnly: true,
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());

                            if (selectedDate != null) {
                              controller.dobController.text =
                                  DateFormat('dd.MM.yyyy').format(selectedDate);
                            }
                          },
                          validator: (value) =>
                              CustomValidations.validateString(value ?? ''),
                          controller: controller.dobController,
                          prefixIcon: Icon(Icons.date_range,
                              color: AppColor.primaryColor),
                          hintText: 'Date of Birth',
                        ),
                      ),
                      spacing(height: 30),
                      Form(
                        key: addressNKey,
                        child: AppTextFiled(
                          validator: (value) =>
                              CustomValidations.validateString(value ?? ''),
                          controller: controller.addressController,
                          prefixIcon:
                              Icon(Icons.textsms, color: AppColor.primaryColor),
                          hintText: 'Address',
                        ),
                      ),
                      spacing(height: 30),
                      Obx(
                        () => FullWidthButton(
                          isLoading: controller.isLoading.value,
                          buttonText: 'Save Changes',
                          buttonTap: () {
                            if (firstNKey.currentState!.validate() &&
                                lastNKey.currentState!.validate() &&
                                phoneNKey.currentState!.validate() &&
                                dobNKey.currentState!.validate() &&
                                addressNKey.currentState!.validate()) {
                              controller.updateProfile();
                            }
                          },
                        ),
                      ),
                      spacing(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
