import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/age_radio_body.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgeInfoPage extends StatelessWidget {
  const AgeInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeSettingBloc, SettingState>(builder: (context, state) {
      return (state is SettingStateLoading)
          ? const Scaffold(
              body: DropAndGoButtonLoading(),
            )
          : (state is SettingStateLoaded)
              ? Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: Hero(
                      tag: 'progress',
                      child: OnboardingAppbar(
                        barValue: .33,
                        onBack: () {
                          getIt<NavigationService>()
                              .navigateBack(context: context);
                        },
                      ),
                    ),
                  ),
                  body: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        margin: const EdgeInsets.only(
                          left: 35,
                          top: 20,
                          right: 35,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StandardText.headline4(
                              context,
                              'onboarding.age_title'.tr(),
                            ),
                            10.verticalGap,
                            StandardText.headline6(
                              context,
                              'onboarding.age_subtitle'.tr(),
                            ),
                            31.verticalGap,
                            const AgeRadioBody(),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 50,
                                ),
                                alignment: Alignment.bottomCenter,
                                child: AppButton(
                                  width: constraints.maxWidth,
                                  text: 'onboarding.continue'.tr(),
                                  isPrefixIcon: false,
                                  icon: SvgPicture.asset(
                                    DropAndGoIcons.arrowForward,
                                  ),
                                  onPressed: () {
                                    getIt<NavigationService>().navigateToNamed(
                                      context: context,
                                      uri: NavigationService
                                          .onboardingAchievementRouteUri,
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : (state is SettingStateError)
                  ? Scaffold(
                      body: Center(
                        child: StandardText.headline6(context, state.message),
                      ),
                    )
                  : const SizedBox.shrink();
    });
  }
}
