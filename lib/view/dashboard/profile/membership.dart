import 'package:atfb/components/app_buttons/full_width_button.dart';
import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';

import '../../../export_files/export_files_must.dart';

class Membership extends StatefulWidget {
  const Membership({super.key});

  @override
  State<Membership> createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appbarTitle: 'Membership',
        isLeading: true,
      ),
      backgroundColor: Colors.white,
      body: Expanded(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            spacing(height: 50),
            Container(
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: AppColor.primaryColor,
                      blurRadius: 178,
                      spreadRadius: 0,
                      blurStyle: BlurStyle.normal,
                      offset: const Offset(0, 4)),
                  BoxShadow(
                      color: AppColor.primaryColor,
                      blurRadius: 137,
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 0,
                      offset: const Offset(0, 4)),
                ], // Optional rounded corners
              ),
              width: Get.width,
              child: Image.asset(AppImages.membership),
            ),
            spacing(height: 10),
            Text(
              'Pay & Go Ad-Free',
              style: AppTextStyle.semiBoldPrimary(fontSize: 27),
            ),
            spacing(height: 30),
            Container(
              padding:
                  EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                  color: AppColor.lightPrimaryA600.withOpacity(0.17),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: AppColor.primaryColor)),
              child: Row(
                children: [
                  Image.asset(AppImages.dndIcon, height: 40, width: 40),
                  spacing(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No ads — ever',
                          style: AppTextStyle.semiBoldBlack(fontSize: 18),
                        ),
                        Text(
                          'Enjoy the app without interruptions',
                          style: AppTextStyle.regularCustom(
                              fontSize: 16,
                              color: AppColor.grey121212.withOpacity(0.60)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            spacing(height: 35),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.noAds,
                height: 100,
                width: 120,
              ),
            ),
            spacing(height: 15),
            Text(
              'Pure content \n Zero distractions',
              textAlign: TextAlign.center,
              style: AppTextStyle.semiBoldBlack(fontSize: 21),
            ),
            spacing(height: 25),
            FullWidthButton(buttonText: 'Upgrade Now')
          ],
        ),
      ))),
    );
  }
}
