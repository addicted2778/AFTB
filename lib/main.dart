import 'package:atfb/export_files/export_files_must.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColor.primaryColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          applyElevationOverlayColor: false,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            foregroundColor: AppColor.primaryColor, // "CANCEL"/"OK" buttons
          )),
          primarySwatch: AppColor.primaryColor.toMaterialColor(),
          colorScheme: ColorScheme.light(
            primary: AppColor.primaryColor, // selected date, header
            onPrimary: Colors.white, // text on selected date/header
            onSurface: Colors.black, // default calendar text
          ),
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: AppColor.primaryColor,
            cursorColor: AppColor.primaryColor,
          )),
      getPages: AppPages.appRoutes(context),
      debugShowCheckedModeBanner: false,
      title: 'AFTB',
      home: const SplashScreen(),
    );
  }
}
