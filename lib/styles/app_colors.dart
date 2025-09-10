import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static final Color primaryColor = hex('#E28725');
  static final Color black1212OP60 = hex('#121212').withOpacity(0.60);
  static final Color lightPrimaryOP43 = hex('#FCC98E').withOpacity(0.43);
  static final Color lightPrimary = hex('#FCC98E');
  static final Color lightPrimaryA600 = hex('#EDA600');
  static final Color grey606060 = hex('#606060');
  static final Color grey808080 = hex('#808080');
  static final Color black2E2A2A = hex('#2E2A2A');
  static final Color grey747775 = hex('#747775');
  static final Color greyAEACAC = hex('#AEACAC');
  static final Color grey8C8C8C = hex('#8C8C8C');
  static final Color green34A853 = hex('#34A853');
  static final Color grey616361 = hex('#616361');
  static final Color grey121212 = hex('#121212');
  static final Color greyECECEC = hex('#ECECEC');
  static final Color grey858996 = hex('#858996');
  static final Color greyEFEFEF = hex('#EFEFEF');

  static Color hex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ColorConversion on Color {
  MaterialColor toMaterialColor() {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(value, swatch);
  }
}
