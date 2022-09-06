import 'package:flutter/material.dart';

class AppColors {
  static Color primary = Color(0xff29B7AB);
  static Color primary100 = Color(0xff2EC4B6);
  static Color secondary = Color(0xffDFF9EE);
  static Color ternary = Color(0xffF57D41);
  static Color yellow = Color(0xffFFCC00);
  static Color bacground = Color(0xffF8F8F8);
  static Color blue = Color(0xff4780BE);
  static Color pink = Color(0xffDC5B8A);
  static Color overley = Color(0xFF4F5867);
  static Color purple = Color(0xFF895BB7);

  static Color darkBlue = Color(0xff0A3F77);
  static Color semiDarkBlue = Color(0xff41617E);

  static Color red = Color(0xffEB4B4B);

  // static Color lineCard = Color(0xffFAFAFA);
  static Color lightGrey = Color(0xffEDEEF0);
  static Color mediumLightGrey = Color(0xffDCDEE1);
  static Color turquoiseLightGrey = Color(0xffEDF1F7);
  static Color turquoiseLight = Color(0xffE9F8F7);
  static Color amberLight = Color(0xFFF89D70);

  static Color grey = Color(0xFF9E9E9E);

  static Color turquoiseMediumLight = Color(0xffEAF9F8);
  static Color darkGrey = Color(0xff5B5B5D);
  static Color disabledGrey = Color(0xffB9BCC2);

  static Color white = Color(0xffffffff);
  // static Color smokeWhiteGrey = Color(0xFFF0F0F0);
  static Color black = Color(0xff000000);
  static Color black100 = Color(0xFF4F5867);

  // Fonts
  static Color fontGrey = Color(0xff848A95);
  static Color fontDarkGrey = Color(0xff4F5867);

  // Background
  static Color grayedBackground = Color(0xFFFAFAFA);
  static Color mediumGrayBackground = Color(0xFFF0F0F0);

  // Gradients
  static Color turquoiseLightGradient = Color(0xFFCBF3F0);

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
