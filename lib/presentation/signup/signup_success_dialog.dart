import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/signup/widgets/success_placeholder.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_dialog.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupSuccessDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      barrierColor: DropAndGoColors.transparent,
      context: context,
      builder: (context) => BlocListener<SignupSuccessSettingBloc, SettingState>(
        listener: (context, state) async{
          if (state is SettingStateLoaded) {
            await Future.delayed(const Duration(seconds: 3)).then(
              (value) => getIt<NavigationService>().replaceWithNamed(
                context: context,
                uri: NavigationService.homeRouteUri,
              ),
            );
          }
        },
        child: BlocBuilder<SignupSuccessSettingBloc, SettingState>(
            builder: (context, settingState) {
          return (settingState is SettingStateLoading)
              ? const AppDialog(
                  actions: [
                    DropAndGoButtonLoading(),
                  ],
                )
              : (settingState is SettingStateLoaded)
                  ? AppDialog(
                      header: const SuccessPlaceholder(),
                      title: settingState.setting?.title ?? '',
                      description: settingState.setting?.subtitle ?? '',
                      // title: 'create_account.success'.tr(),
                      // description: 'onboarding.profile_subtitle'.tr(),
                    )
                  : (settingState is SettingStateError)
                      ? AppDialog(
                          title: "Error",
                          description: settingState.message,
                        )
                      : const SizedBox.shrink();
        }),
      ),
    );
  }
}
