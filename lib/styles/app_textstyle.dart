import 'package:atfb/export_files/export_files_must.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  double fontSize = 0.0;
  static String kFontFamily = "Poppins";

  static TextStyle get appBar => TextStyle(
        fontSize: 20,
        fontFamily: kFontFamily,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
  static TextStyle semiBoldPrimary(
          {double fontSize = 14.0,
          TextDecoration decoration = TextDecoration.none}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: AppColor.primaryColor,
        decoration: decoration,
        fontWeight: FontWeight.w600,
      );
  static TextStyle semiBoldCustom(
          {double fontSize = 14.0,
          Color color = Colors.black,
          TextDecoration decoration = TextDecoration.none}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: color,
        decoration: decoration,
        fontWeight: FontWeight.w600,
      );
  static TextStyle boldPrimary(
          {double fontSize = 14.0,
          TextDecoration decoration = TextDecoration.none}) =>
      TextStyle(
        fontSize: fontSize,
        decoration: decoration,
        fontFamily: kFontFamily,
        color: AppColor.primaryColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle boldBlack({double fontSize = 14.0}) => TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );
  static TextStyle boldCustom(
          {double fontSize = 14.0,
          Color color = Colors.black,
          TextDecoration decoration = TextDecoration.none}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        decoration: decoration,
        decorationColor: color,
        color: color,
        fontWeight: FontWeight.bold,
      );
  static TextStyle boldWhite(
          {double fontSize = 14.0,
          TextDecoration decoration = TextDecoration.none}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        decoration: decoration,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
  static TextStyle semiBoldBlack(
          {double fontSize = 14.0,
          TextDecoration decoration = TextDecoration.none}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        decoration: decoration,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      );
  static TextStyle semiBoldWhite(
          {double fontSize = 14.0,
          TextDecoration decoration = TextDecoration.none}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        decoration: decoration,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );
  static TextStyle mediumBlack({double fontSize = 14.0}) => TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );
  static TextStyle mediumWhite({double fontSize = 14.0}) => TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );
  static TextStyle mediumCustom(
          {double fontSize = 14.0, Color color = Colors.black}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: color,
        fontWeight: FontWeight.w500,
      );
  static TextStyle regularCustom(
          {double fontSize = 14.0, Color color = Colors.black}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: color,
        fontWeight: FontWeight.w400,
      );
  static TextStyle regularWhite(
          {double fontSize = 14.0, Color color = Colors.black}) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      );
  static TextStyle regularBlack({
    double fontSize = 14.0,
  }) =>
      TextStyle(
        fontSize: fontSize,
        fontFamily: kFontFamily,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      );
}
