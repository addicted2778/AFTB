import 'package:atfb/components/app_buttons/full_width_button.dart';
import 'package:atfb/components/app_text_filed.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/custom_validation.dart';
import 'package:atfb/utils/global.dart';

import 'package:get/get.dart';

import '../../../controller/delete_account_controller.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  DeleteAccountController controller = Get.put(DeleteAccountController());

  final reasonKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(appbarTitle: 'Delete Account'),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            Form(
              key: reasonKey,
              child: AppTextFiled(
                hintText: 'Type a reason why you want to delete your account',
                maxlines: 8,
                controller: controller.reasonController,
                prefixIcon:
                    Icon(Icons.email_outlined, color: AppColor.primaryColor),
                validator: (value) =>
                    CustomValidations.validateString(value ?? ''),
              ),
            ),
            spacing(height: 20),
            FullWidthButton(
              buttonText: 'Delete Account',
              buttonTap: () {
                if (reasonKey.currentState!.validate()) {
                  controller.deleteAccount();
                }
              },
              isLoading: controller.isLoading.value,
            )
          ],
        ),
      ),
    );
  }
}
