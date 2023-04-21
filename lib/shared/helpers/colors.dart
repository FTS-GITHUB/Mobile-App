import 'package:flutter/material.dart';

abstract class DropAndGoColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color primary = black;
  static const Color progressBarBg = Color(0xFFD1D1D1);
  static const Color red = Colors.red;
  static const Color transparent = Colors.transparent;
  static const Color homeIcon = Color(0xFFFFA800);
  static const Color downloadIcon = Color(0xFF1877F2);
  static const Color analyticsIcon = Color(0xFFFF0000);
  static const Color profileIcon = Color(0xFF149200);
  static ColorFilter? appColorFilter = ColorFilter.mode(
    black.withOpacity(.4),
    BlendMode.hardLight,
  );
// #FFA800
}
