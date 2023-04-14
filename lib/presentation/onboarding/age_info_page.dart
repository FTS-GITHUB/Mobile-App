import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/age_radio_body.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgeInfoPage extends StatelessWidget {
  const AgeInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ageCubit = context.read<AgeCubit>();
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
                        margin: EdgeInsets.only(
                          left: 35.h,
                          top: 20.h,
                          right: 35.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StandardText.headline4(
                              context,
                              state.setting?.title ?? '',
                              // 'onboarding.age_title'.tr(),
                            ),
                            10.h.verticalGap,
                            StandardText.headline6(
                              context,
                              state.setting?.subtitle ?? '',
                              // 'onboarding.age_subtitle'.tr(),
                            ),
                            31.h.verticalGap,
                            AgeRadioBody(
                              data: state.setting?.data,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: 50.h,
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
                                    if (ageCubit.state.value != null) {
                                      getIt<NavigationService>()
                                          .navigateToNamed(
                                        context: context,
                                        uri: NavigationService
                                            .onboardingAchievementRouteUri,
                                      );
                                    } else {
                                      getIt<Toasts>().showToast(
                                        context,
                                        type: AlertType.Error,
                                        title: "Error",
                                        description: "Please select age and continue",
                                      );
                                    }
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
