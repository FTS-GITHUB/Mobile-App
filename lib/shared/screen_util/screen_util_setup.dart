import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//A flutter plugin for adapting screen and font size.Let your UI display a reasonable layout on different screen sizes!
class ScreenUtilSetup{

  static void initialize(BuildContext context){
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );
  }
}
