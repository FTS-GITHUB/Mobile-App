import 'package:flutter/widgets.dart';
import 'font_family.dart';
import 'font_weights.dart';

class DropAndGoTextStyle {
  static const TextStyle _baseTextStyle = TextStyle(
    fontFamily: DropAndGoFontFamily.poppins,
    // color: DropAndGoColors,
  );

  /// Headline 1 Text Style
  static TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 45,
      fontWeight: DropAndGoFontWeight.bold,
    );
  }

  /// Headline 2 Text Style
  static TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 40,
      fontWeight: DropAndGoFontWeight.bold,
    );
  }

  /// Headline 3 Text Style
  static TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      fontWeight: DropAndGoFontWeight.extraBold,
    );
  }

  /// Headline 4 Text Style
  static TextStyle get headline4 {
    return _baseTextStyle.copyWith(
      fontSize: 25,
      fontWeight: DropAndGoFontWeight.bold,
    );
  }

  /// Headline 5 Text Style
  static TextStyle get headline5 {
    return _baseTextStyle.copyWith(
      fontSize: 15,
      fontWeight: DropAndGoFontWeight.semiBold,
    );
  }

  /// Headline 6 Text Style
  static TextStyle get headline6 {
    return _baseTextStyle.copyWith(
      fontSize: 15,
      fontWeight: DropAndGoFontWeight.regular,
    );
  }

  /// Subtitle 1 Text Style
  static TextStyle get subtitle1 {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: DropAndGoFontWeight.medium,
    );
  }

  /// Subtitle 2 Text Style
  static TextStyle get subtitle2 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: DropAndGoFontWeight.semiBold,
    );
  }

  static TextStyle get subtitle3 {
    return _baseTextStyle.copyWith(
      fontSize: 13,
      fontWeight: DropAndGoFontWeight.regular,
    );
  }

  /// Body Text 1 Text Style
  static TextStyle get bodyText1 {
    return _baseTextStyle.copyWith(
      fontSize: 17,
      fontWeight: DropAndGoFontWeight.medium,
    );
  }

  /// Body Text 2 Text Style (the default)
  static TextStyle get bodyText2 {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: DropAndGoFontWeight.regular,
    );
  }

  /// Caption Text Style
  static TextStyle get caption {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: DropAndGoFontWeight.regular,
    );
  }

  static TextStyle get captionBold {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: DropAndGoFontWeight.black,
    );
  }

  /// Overline Text Style
  static TextStyle get overline {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: DropAndGoFontWeight.black,
    );
  }

  // hint text style
  static TextStyle get hintStyle {
    return _baseTextStyle.copyWith(
      fontSize: 15,
      fontWeight: DropAndGoFontWeight.medium,
    );
  }
  // customStyle text style
  static TextStyle get customStyle {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      color: const Color(0xFF666666),
      fontWeight: DropAndGoFontWeight.regular,
    );
  }

  /// Button Text Style
  static TextStyle get button {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: DropAndGoFontWeight.medium,
      letterSpacing: 1,
    );
  }

}
