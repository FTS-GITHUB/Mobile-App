import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension DoubleExtension on num {
  // use for all static height throughout the entire app
  // ignore: unnecessary_cast
  double get flexibleHeight => ScreenUtil().setHeight(this);

  // use for all static wid
  // th throughout the entire app
  // ignore: unnecessary_cast
  double get flexibleWidth => ScreenUtil().setWidth(this) as double;
  // use for all font size throughout the entire app
  // ignore: unnecessary_cast
  double get flexibleFontSize => ScreenUtil().setSp(this) as double;

  /// Use to add horizontal space
  // ignore: unnecessary_cast
  SizedBox get horizontalGap => SizedBox(width: flexibleWidth);
  // Use to add vertical space
  SizedBox get verticalGap => SizedBox(height: flexibleHeight);

}

extension IntExtension on int{
  String toCompactNumber(){
    String num = NumberFormat.compact().format(this);
    return num;
  }

}