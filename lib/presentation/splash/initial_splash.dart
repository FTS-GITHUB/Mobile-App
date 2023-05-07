import 'dart:async';

import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InitialSplashPage extends StatefulWidget {
  const InitialSplashPage({Key? key}) : super(key: key);

  @override
  State<InitialSplashPage> createState() => _InitialSplashState();
}

class _InitialSplashState extends State<InitialSplashPage> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(
      seconds: 1,
    ), (timer) {

    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StandardText.headline1(
            context,
            'splash.title'.tr().toUpperCase(),
            height: 0.5,
          ),
          10.h.verticalGap,
          StandardText.headline6(
            context,
            'splash.caption'.tr().toUpperCase(),
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
