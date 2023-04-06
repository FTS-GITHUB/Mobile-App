import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/constants/assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StandardText.headline1(
                  context,
                  'splash.title'.tr().toUpperCase(),
                  height: 0.5,
                ),
                10.verticalGap,
                StandardText.headline6(
                  context,
                  'splash.caption'.tr().toUpperCase(),
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 50,
              left: 35,
              right: 35,
            ),
            alignment: Alignment.bottomCenter,
            child: AppButton(
              text: "Let's Start",
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
          )
        ],
      ),
    );
  }
}
