import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/level_radio_body.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserLevelInfoPage extends StatelessWidget {
  const UserLevelInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userLevelCubit = context.read<UserLevelCubit>();
    return BlocBuilder<RecommendationSettingBloc, SettingState>(
        builder: (context, state) {
      return (state is SettingStateLoading)
          ? const Scaffold(
              body: DropAndGoButtonLoading(),
            )
          : (state is SettingStateLoaded)
              ? Scaffold(
                  backgroundColor: DropAndGoColors.white,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: Hero(
                      tag: 'progress',
                      child: OnboardingAppbar(
                        barValue: .65,
                        onBack: () {
                          getIt<NavigationService>()
                              .navigateBack(context: context);
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
                          state.setting?.title??'N/A'
                          // 'onboarding.level_title'.tr(),
                        ),
                        45.verticalGap,
                        LevelRadioBody(
                          data: state.setting?.data,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
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
                              if(userLevelCubit.state.title!=null){
                                getIt<NavigationService>().navigateToNamed(
                                  context: context,
                                  uri: NavigationService.completeProfileRouteUri,
                                );
                              }else{
                                getIt<Toasts>().showToast(
                                  context,
                                  type: AlertType.Error,
                                  title: "Error",
                                  description: "Please select level and continue",
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
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
