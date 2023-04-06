import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/achievement_radio_body.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AchievementInfoPage extends StatelessWidget {
  const AchievementInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Hero(
          tag: 'progress',
          child: OnboardingAppbar(
            barValue: .49,
            onBack: (){
              getIt<NavigationService>().navigateBack(context: context);
            },
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 35,
          top: 20,
          right: 35,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            StandardText.headline4(
              context,
              'onboarding.ach_title'.tr(),
            ),
            10.verticalGap,
            StandardText.headline6(
              context,
              'onboarding.ach_subTitle'.tr(),
            ),
            15.verticalGap,
            const AchievementRadioBody(),
            Container(
              margin: const EdgeInsets.only(
                top: 19,
                bottom: 43,
              ),
              alignment: Alignment.bottomCenter,
              child: AppButton(
                width: context.width,
                text: 'onboarding.continue'.tr(),
                isPrefixIcon: false,
                icon: SvgPicture.asset(
                  DropAndGoIcons.arrowForward,
                ),
                onPressed: () {
                  getIt<NavigationService>().navigateToNamed(
                    context: context,
                    uri: NavigationService.onboardingLevelRouteUri,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
