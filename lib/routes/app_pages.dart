import 'package:atfb/components/app_bottom_bar.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/view/auth/new_password.dart';
import 'package:atfb/view/auth/verify_otp_forgot_password.dart';
import 'package:atfb/view/dashboard/home/home_screen.dart';
import 'package:atfb/view/dashboard/home/view_full_day.dart';
import 'package:atfb/view/dashboard/profile/change_password.dart';
import 'package:atfb/view/dashboard/profile/delete_account.dart';
import 'package:atfb/view/dashboard/profile/membership.dart';
import 'package:get/get.dart';

import '../view/intro_screens/intro_screen.dart';

class AppPages {
  static appRoutes(context) => [
        GetPage(name: PageNames.splashScreen, page: () => const SplashScreen()),
        GetPage(name: PageNames.loginScreen, page: () => const LoginScreen()),
        GetPage(name: PageNames.verifyOtp, page: () => const VerifyOtp()),
        GetPage(name: PageNames.newPassword, page: () => const NewPassword()),
        GetPage(name: PageNames.viewFullDay, page: () => const ViewFullDay()),
        GetPage(name: PageNames.introScreens, page: () => const IntroScreen()),
        GetPage(name: PageNames.membership, page: () => const Membership()),
        GetPage(
            name: PageNames.deleteAccount, page: () => const DeleteAccount()),
        GetPage(
            name: PageNames.changePassword, page: () => const ChangePassword()),
        GetPage(
            name: PageNames.forgotPassword, page: () => const ForgotPassword()),
        GetPage(
            name: PageNames.homeScreen,
            page: () => AppBottomBar(
                  selectedIndex: 1,
                )),
        GetPage(
            name: PageNames.weeklyPlan,
            page: () => AppBottomBar(
                  selectedIndex: 0,
                )),
        GetPage(
            name: PageNames.profileScreen,
            page: () => AppBottomBar(
                  selectedIndex: 2,
                )),
      ];
}
