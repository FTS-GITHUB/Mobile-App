import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/constants/assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
          174.h.verticalGap,
          Container(
            margin: EdgeInsets.only(
              bottom: 20.h,
              left: 35.w,
              right: 35.w,
            ),
            alignment: Alignment.bottomCenter,
            child: AppButton(
              text: "splash.button".tr(),
              icon: SvgPicture.asset(DropAndGoIcons.arrowForward),
              isPrefixIcon: false,
              width: context.width,
              onPressed: () {
                getIt<NavigationService>().navigateToNamed(
                  context: context,
                  uri: NavigationService.onboardingGenderRouteUri,
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 50.h,
              left: 35.w,
              right: 35.w,
            ),
            alignment: Alignment.bottomCenter,
            child: AppButton(
              color: DropAndGoColors.white,
              text: "Already Have an Account?",
              textColor: DropAndGoColors.primary,
              icon: SvgPicture.asset(
                DropAndGoIcons.arrowForward,
                color: DropAndGoColors.primary,
              ),
              isPrefixIcon: false,
              width: context.width,
              onPressed: () {
                getIt<NavigationService>().navigateToNamed(
                  context: context,
                  uri: NavigationService.loginRouteUri,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
