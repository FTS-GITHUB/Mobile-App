import 'package:flutter/material.dart';

abstract class DropAndGoColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color primary = black;
  static const Color progressBarBg = Color(0xFFD1D1D1);
  static const Color red = Colors.red;
  static const Color transparent = Colors.transparent;
  static const Color homeIcon = Color(0xFFFFA800);
  static const Color analyticsIcon = Color(0xFFFF0000);
  static const Color profileIcon = Color(0xFF149200);
  static ColorFilter? appColorFilter = ColorFilter.mode(
    black.withOpacity(.4),
    BlendMode.hardLight,
  );
  static const Color purple = Color(0xFF9510B8);
  static const Color blue = Color(0xFF1877F2);
  static const Color green = Color(0xFF17600B);
  static const Color yellow = Color(0xFFFFBF00);
  static const Color orange = Color(0xFFDD5000);
  static const Color lightGreen = Color(0xFF149200);
// #149200
}
