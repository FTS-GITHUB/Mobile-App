import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/presentation/complete_profile/widgets/success_placeholder.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_dialog.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupSuccessDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      barrierColor: DropAndGoColors.transparent,
      context: context,
      builder: (context) => BlocBuilder<SignupSuccessSettingBloc, SettingState>(
        builder: (context, settingState) {
          return (settingState is SettingStateLoading)?
              const AppDialog(
               actions: [
                 DropAndGoButtonLoading(),
               ],
              ):
          (settingState is SettingStateLoaded)?
          AppDialog(
            header: const SuccessPlaceholder(),
            title: settingState.setting?.title??'',
            description: settingState.setting?.subtitle??'',
            // title: 'create_account.success'.tr(),
            // description: 'onboarding.profile_subtitle'.tr(),
          ):(settingState is SettingStateError)?AppDialog(
            title: "Error",
            description: settingState.message,
          ):const SizedBox.shrink();
        }
      ),
    );
  }
}
