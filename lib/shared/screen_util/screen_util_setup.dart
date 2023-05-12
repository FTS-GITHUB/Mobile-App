import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//A flutter plugin for adapting screen and font size.Let your UI display a reasonable layout on different screen sizes!
class ScreenUtilSetup extends StatelessWidget {
  final Widget? child;

  const ScreenUtilSetup({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromView(WidgetsBinding.instance.window),
      child: Builder(
        builder: (BuildContext context) {
          ScreenUtil.init(
            context,
            designSize: const Size(390, 844),
          );
          return child!;
        },
      ),
    );
  }
}
