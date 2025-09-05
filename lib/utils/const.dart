// ignore_for_file: file_names

import 'dart:io' show Platform;

import 'package:atfb/model/site_setting_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Styles/app_colors.dart';

String userMobileNumber = "1234567890";

var fcmToken = "FCM_TOKEN";
var KEY_TOKEN = "KEY_TOKEN";
var KEY_USER_ID = "KEY_USER_ID";
var KEY_DEVICE_INFO = 'KEY_DEVICE_INFO';
var KEY_BUILD_NUMBER = 'KEY_BUILD_NUMBER';
var KEY_VERSION_APP = 'KEY_VERSION_APP';
var apiVersion = '1';
var KEY_UNIQUE_DEVICE_ID = 'KEY_UNIQUE_DEVICE_ID';
var KEY_LOGIN = 'KEY_LOGIN';
var KEY_INTRO_SCREEN = 'KEY_INTRO_SCREEN';
var KEY_DEVICE_NAME = 'KEY_DEVICE_NAME';

var userLocation = ''.obs;
var userLatitude = ''.obs;
var userLongitude = ''.obs;
var selectedAreaId = ''.obs;
var selectedAreaName = ''.obs;
var getLinkApiHitCount = 0.obs;

var termsAndConditionUrl = 'termsAndCondition';
var privacyPolicyUrl = 'privacyPolicy';
var contactUsUrl = 'contactUs';
var faqUrl = 'faq';
var baseUrl = 'https://turfportals.com/';

// var userData = UserData().obs;
var siteSettingData = SiteSettingData().obs;

Future<String> get appPackageName async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String packageName = packageInfo.packageName;

  return packageName;
}

Future<String> appBuildNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String buildNumber = packageInfo.buildNumber;
  KEY_BUILD_NUMBER = buildNumber;
  return buildNumber;
}

Future<String> appVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String version = packageInfo.version;
  KEY_VERSION_APP = version;

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(KEY_VERSION_APP, packageInfo.version);
  return packageInfo.version;
}

Future<String> get appName async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;

  return appName;
}

Future<String> deviceModelName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(KEY_DEVICE_NAME,
        'Android $release (SDK $sdkInt), $manufacturer $model');

    return androidInfo.model;
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    var systemName = iosInfo.systemName;
    var version = iosInfo.systemVersion;
    var name = iosInfo.name;
    var model = iosInfo.model;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        KEY_DEVICE_NAME, '$systemName $version, $name $model');

    return iosInfo.identifierForVendor!;
  }
}

Future<String> deviceUniqueId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(KEY_UNIQUE_DEVICE_ID, androidInfo.id);

    return androidInfo.id;
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        KEY_UNIQUE_DEVICE_ID, iosInfo.identifierForVendor!);

    return iosInfo.identifierForVendor!;
  }
}

// Future<String> get firebaseToken async {
//   try {
//     final token = await FirebaseMessaging.instance.getToken();
//
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     await sharedPreferences.setString(fcmToken, token!);
//
//     return token;
//   } catch (error) {
//     sendErrorEmail(error: error.toString());
//     return '';
//   }
// }

Future<String> getDeviceInfo() async {
  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    KEY_DEVICE_INFO = 'Android $release (SDK $sdkInt), $manufacturer $model';
    // Android 9 (SDK 28), Xiaomi Redmi Note 7
  }

  if (Platform.isIOS) {
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    var systemName = iosInfo.systemName;
    var version = iosInfo.systemVersion;
    var name = iosInfo.name;
    var model = iosInfo.model;
    KEY_DEVICE_INFO = '$systemName $version, $name $model';
    // iOS 13.1, iPhone 11 Pro Max iPhone.
  }
  return KEY_DEVICE_INFO;
}

customPrint({required String printValue}) {
  if (kDebugMode) {
    return debugPrint(printValue);
  } else {
    return;
  }
}

customSnackbar(String description) {
  Get.closeAllSnackbars();
  return Get.snackbar(
    'AFTB',
    description,
    backgroundColor: AppColor.primaryColor,
    colorText: Colors.white,
  );
}
