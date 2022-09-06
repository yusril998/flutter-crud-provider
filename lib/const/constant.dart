import 'package:flutter/material.dart';

class Constant {
  static int limit = 10;
  static Color primary = Colors.green;
  static Color background = Color(0xffF5F5F3);
  static Gradient gradient =
      LinearGradient(colors: [Colors.green, Colors.greenAccent]);
  static Gradient gradientImage = LinearGradient(
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      colors: [
        Colors.white.withOpacity(0.30),
        Colors.green.shade800.withOpacity(0.30),
        Colors.green.shade800.withOpacity(0.40),
        Colors.green.shade800.withOpacity(0.50),
        Colors.black.withOpacity(0.65),
        Colors.black.withOpacity(0.75),
      ]);
  static List<String> listBackGround = [
    'assets/img/1.png',
    'assets/img/2.png',
    'assets/img/3.png',
    'assets/img/4.png',
    'assets/img/5.png',
    'assets/img/6.png',
    'assets/img/7.png',
    'assets/img/8.png',
    'assets/img/9.png',
    'assets/img/10.png',
  ];
}
