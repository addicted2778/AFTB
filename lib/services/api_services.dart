// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:atfb/utils/preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../utils/const.dart';
import '../view/auth/login_screen.dart';

class API {
  API._privateConstructor();

  bool kIsStagingURL = false;
  static final API instance = API._privateConstructor();

  String get kBaseURL {
    if (kIsStagingURL) {
      return 'https://kbdevs.com/atfb/api/users/v1/';
    } else {
      return 'https://kbdevs.com/atfb/api/users/v1/';
    }
  }

  String internetConnectPoorBody = 'Internet connection is poor.';
  int internetConnectPoorCode = 1111;

  int apiExceptionCode = 1112;

  Future<bool> _checkInternet() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  checkInternetSlow(http.Response response) {
    Future.delayed(const Duration(seconds: 1), () {
      if (response.statusCode == 1111) {}
    });
  }

  Future<http.Response> post(
      {required String endPoint,
      required Map<String, dynamic> params,
      bool isHeader = true}) async {
    if (!await _checkInternet()) {
      // customSnackbar('Internet not connected');
    }

    final url = Uri.parse(kBaseURL + endPoint);

    var tokenAPI = await Preferences.getSharedPref(KEY_TOKEN) ?? '';
    var fcm_token = await Preferences.getSharedPref(fcmToken);
    var device_unique_id =
        await Preferences.getSharedPref(KEY_UNIQUE_DEVICE_ID);
    var device_name = await Preferences.getSharedPref(KEY_DEVICE_NAME);
    var appVer = await Preferences.getSharedPref(KEY_VERSION_APP);

    params['device_token'] = fcm_token ?? '111111';
    params['app_version'] = '1';
    params['api_version'] = '1';
    params['unique_device_id'] = '11111';
    params['device_details'] = '111111';
    // params['debug_mode'] = (kDebugMode) ? 'true' : 'false';
    if (!kIsWeb) {
      params['device_type'] = (Platform.isAndroid) ? 'android' : 'ios';
    }

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        "Accept": "application/json",
        "lang": "en",
        if (tokenAPI != '') "Authorization": "Bearer $tokenAPI"
      };
    }

    // final bodyParams = {"reqObject": jsonEncode(params)};

    try {
      final response =
          await http.post(url, body: params, headers: header).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      debugPrint('Url :- ${url.toString()}');
      debugPrint('Token :- ${tokenAPI.toString()}');
      debugPrint('parmas :-${jsonEncode(params)})');
      debugPrint('header :-${jsonEncode(header)})');
      log('Response :- ${response.body}');
      checkInternetSlow(response);

      if (response.statusCode == 500) {
        // Get.offAll(ServerError());
      }

      final data = json.decode(response.body);

      final status = data['status'];

      if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        deviceUniqueId();
        deviceModelName();
        appVersion();
        Get.offAll(LoginScreen());
      }

      return response;
    } catch (error) {
      debugPrint('Error is:- ${error.toString()}');

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> postStringBodyParams(
      {required String endPoint,
      required String params,
      bool isHeader = false}) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse(kBaseURL + endPoint);
    //debugPrint(url.toString());

    Map<String, String> header = {};
    if (isHeader) {
      header = {
        'Content-Type':
            'multipart/form-data; boundary=<calculated when request is sent>',
        'Content-Length': '<calculated when request is sent>',
        'Host': '<calculated when request is sent>',
        'User-Agent': 'PostmanRuntime/7.32.3',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      };
    }

    try {
      final response =
          await http.post(url, body: params, headers: header).timeout(
        const Duration(seconds: 1),
        onTimeout: () {
          return http.Response(
              internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      checkInternetSlow(response);

      return response;
    } catch (error) {
      //debugPrint('Error is:- ${error.toString()}');

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> postImage({
    required String endPoint,
    required Map<String, dynamic> params,
    required String fileParams,
    required File? file,
  }) async {
    if (!await _checkInternet()) {
      // return http.Response("", 0);
    }

    final url = Uri.parse('$kBaseURL$endPoint');
    var tokenAPI = await Preferences.getSharedPref(KEY_TOKEN);
    var fcm_token = await Preferences.getSharedPref(fcmToken);

    params['device_id'] = fcm_token ?? '';
    params['device_info'] = KEY_DEVICE_INFO;
    params['app_version'] = KEY_BUILD_NUMBER;
    params['api_version'] = apiVersion;
    var appVer = await Preferences.getSharedPref(KEY_VERSION_APP);
    params['debug_mode'] = (kDebugMode) ? 'true' : 'false';

    if (!kIsWeb) {
      params['device_type'] = (Platform.isAndroid) ? 'android' : 'ios';
    }

    final request = http.MultipartRequest('POST', url);

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = '$tokenAPI';

    params.forEach((key, value) {
      request.fields[key] = value;
    });

    debugPrint('URL :- $url');
    debugPrint('params :- ${params.toString()}');

    try {
      if (file!.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath(fileParams, file.path));
      }

      final response = await request.send();

      final res = await http.Response.fromStream(response).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response('Internet connection is poor.', 1111);
        },
      );
      log(res.body);

      final data = json.decode(res.body);

      final status = data['status'];

      if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        deviceUniqueId();
        deviceModelName();
        appVersion();
        Get.offAll(const LoginScreen());
/*        Get.showSnackbar(GetSnackBar(
          backgroundColor: ColorStyle.primaryColor,
          duration: Duration(seconds: 3),
          isDismissible: true,
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM,
          messageText: Text(
            '${data['message']}'.toTitleCase(),
            style: CustomTextStyle.centraTextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ));*/
      }

      return res;
    } catch (error) {
      //debugPrint('Error is:- ${error.toString()}');
      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> multiplePostImage({
    required String endPoint,
    required Map<String, dynamic> params,
    required String fileParams,
    // required String imageParams,
    required File? file,
    // required File? image,
  }) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse('$kBaseURL$endPoint');

    // var tokenAPI = await Preference.getSharedPref(token);
    // var fcm_token = await Preference.getSharedPref(fcmToken);

    // params['device_id'] = fcm_token ?? '';
    // params['device_info'] = deviceInfo;
    // params['app_version'] = buildNumberApp;
    // params['api_version'] = apiVersion;
    params['debug_mode'] = (kDebugMode) ? 'true' : 'false';
    if (!kIsWeb) {
      params['device_type'] = (Platform.isAndroid) ? 'android' : 'ios';
    }

    final request = http.MultipartRequest('POST', url);

    request.headers['Content-Type'] = 'multipart/form-data';
    // request.headers['Authorization'] = '$tokenAPI';

    params.forEach((key, value) {
      request.fields[key] = value;
    });
// image!.path.isNotEmpty
    try {
      if (file!.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath(fileParams, file.path));
        // request.files
        //     .add(await http.MultipartFile.fromPath(imageParams, image.path));
      }

      debugPrint('URL :- $url');
      debugPrint('params :- $params');

      final response = await request.send();

      debugPrint('${response.request.toString()}');
      debugPrint('${response.stream.toString()}');

      final res = await http.Response.fromStream(response).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response('Internet connection is poor.', 1111);
        },
      );
      log('Response :- ${res.body}');

      final data = json.decode(res.body);

      final status = data['status'];

      if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        deviceUniqueId();
        deviceModelName();
        appVersion();
        Get.offAll(LoginScreen());
      }

      return res;
    } catch (error) {
      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  Future<http.Response> multipleImages({
    required String endPoint,
    required Map<String, dynamic> params,
    required String fileParams,
    required List<File>? file,
  }) async {
    if (!await _checkInternet()) {
      return http.Response("", 0);
    }

    final url = Uri.parse('$kBaseURL$endPoint');

    // var tokenAPI = await Preference.getSharedPref(token);
    // var fcm_token = await Preference.getSharedPref(fcmToken);

    // params['device_id'] = fcm_token ?? '';
    // params['device_info'] = deviceInfo;
    // params['app_version'] = buildNumberApp;
    // params['api_version'] = apiVersion;
    params['debug_mode'] = (kDebugMode) ? 'true' : 'false';
    if (!kIsWeb) {
      params['device_type'] = (Platform.isAndroid) ? 'android' : 'ios';
    }
    final request = http.MultipartRequest('POST', url);

    request.headers['Content-Type'] = 'multipart/form-data';
    // request.headers['Authorization'] = '$tokenAPI';

    params.forEach((key, value) {
      request.fields[key] = value;
    });

    try {
      if (file != null && file.isNotEmpty) {
        for (int i = 0; i < file.length; i++) {
          request.files
              .add(await http.MultipartFile.fromPath(fileParams, file[i].path));
        }
      }
      for (var items in request.files) {
        debugPrint('${items.filename}');
      }

      debugPrint('URL :- $url');
      debugPrint('params :- $params');

      final response = await request.send();

      debugPrint(response.request.toString());

      final res = await http.Response.fromStream(response).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          return http.Response('Internet connection is poor.', 1111);
        },
      );

      final data = json.decode(res.body);
      debugPrint('${data}');

      final status = data['status'];

      if (status == 2) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        // firebaseToken;
        deviceUniqueId();
        deviceModelName();
        appVersion();
        Get.offAll(() => LoginScreen());
      }
      return res;
    } catch (error) {
      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

  sendErrorMail({required String params}) async {
    final response = await API.instance.post(
        endPoint: 'user/sendErrorMail',
        params: {"param": params},
        isHeader: true);
  }
}

// getLink() async {
//   final bodyNew = {"reqObject": jsonEncode({})};
//   final response = await API.instance
//       .post(endPoint: APIEndPoints.getLink, params: bodyNew, isHeader: true);
//
//   debugPrint(
//       'data.toString()data.toString()data.toString()data.toString()data.toString()${response.body}');
//   var data = jsonDecode(response.body);
//   var statusCode = data['status'];
//
//   if (statusCode == 1) {
//     getLinkApiHitCount.value++;
//
//     API.instance.terms_and_condition_url =
//         API.instance.kBaseURL + data['data']['terms_and_conditions'];
//     API.instance.privacy_policy_url = data[' data']['privacy_policy'];
//     API.instance.contact_us_url = data['data']['contact_us'];
//     API.instance.faq_url = data['data']['faq'];
//
//     debugPrint(
//         'API.instance.terms_and_condition_url ${API.instance.terms_and_condition_url}');
//   } else {}
// }

class APIEndPoints {
  static const userLogin = 'login';
  static const forgotPassword = 'forgot-password';
  static const resetPassword = 'reset-password';
  static const verifyOtp = 'verify-otp';
  static const deleteAccount = 'delete-account';
  static const updatePassword = 'update-password';
  static const timetable = 'timetable';
  static const siteSetting = 'site-setting';
  static const logout = 'logout';
}
