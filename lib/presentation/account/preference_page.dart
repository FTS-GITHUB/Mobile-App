import 'package:dropandgouser/application/account/account_cubit/preference_cubit.dart';
import 'package:dropandgouser/application/account/account_setting_bloc/account_setting_bloc.dart';
import 'package:dropandgouser/domain/account/preference.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/presentation/account/widgets/audio_quality_dialog.dart';
import 'package:dropandgouser/presentation/account/widgets/clear_cache_dialog.dart';
import 'package:dropandgouser/presentation/account/widgets/icon_forward.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/enums/audio_quality.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/app_switch.dart';

class PreferencePage extends StatelessWidget {
  const PreferencePage({Key? key}) : super(key: key);

  initializePreferences(
    BuildContext context,
    UserSetting? setting,
  ) {
    context.read<PreferenceCubit>().initialize(Preference(
          audioQuality: setting?.audioQuality ?? "Standard",
          downloadWifi: setting?.isDownloadWifi ?? true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var settings = getIt<UserService>().userSetting;
    Toasts toasts = Toasts();
    initializePreferences(context, settings);
    return BlocListener<AccountSettingBloc, AccountSettingState>(
      listener: (context, state) {
        if (state is AccountSettingStateLoaded) {
          getIt<NavigationService>().navigateBack(
            context: context,
          );
        }else if (state is AccountSettingStateError) {
          toasts.showToast(
            context,
            type: AlertType.Error,
            title: "Error",
            description:
            state.message,
          );
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AccountAppBar(
            title: 'Preference',
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StandardText.headline5(
                context,
                'General',
                fontSize: 20,
                fontWeight: DropAndGoFontWeight.semiBold,
              ),
              30.verticalSpace,
              BlocBuilder<PreferenceCubit, Preference>(
                  builder: (context, state) {
                return AppSwitch(
                  title: "Download over WIFI only",
                  isUpperCase: false,
                  switchValue: state.downloadWifi!,
                  onChangedSwitch:
                      context.read<PreferenceCubit>().changeDownloadOverWifi,
                  switchColor: DropAndGoColors.lightGreen,
                );
              }),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => const ClearCacheDialog(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StandardText.headline6(
                        context,
                        'Clear Cache',
                      ),
                      const IconForward(),
                    ],
                  ),
                ),
              ),
              5.verticalSpace,
              StandardText.headline5(
                context,
                'Audio',
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AudioQualityDialog(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StandardText.headline6(
                        context,
                        'Audio Quality',
                      ),
                      BlocBuilder<PreferenceCubit, Preference>(
                          builder: (context, state) {
                        return Row(
                          children: [
                            StandardText.headline6(
                              context,
                              state.audioQuality ?? AudioQuality.Standard.name,
                            ),
                            const IconForward(),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              BlocBuilder<AccountSettingBloc, AccountSettingState>(
                  builder: (context, state) {
                return (state is AccountSettingStateLoading)
                    ? const DropAndGoButtonLoading()
                    : AppButton(
                        width: context.width,
                        text: 'login.confirm'.tr(),
                        onPressed: () {
                          UserSetting? userSetting = settings?.copyWith(
                            isDownloadWifi: context
                                .read<PreferenceCubit>()
                                .state
                                .downloadWifi,
                            audioQuality: context
                                .read<PreferenceCubit>()
                                .state
                                .audioQuality,
                          );
                          if (userSetting != null) {
                            context.read<AccountSettingBloc>().add(
                                  UpdateUserSetting(
                                    userSetting: userSetting,
                                  ),
                                );
                          } else {
                            toasts.showToast(
                              context,
                              type: AlertType.Error,
                              title: "Error",
                              description:
                                  "Failed to update settings, try again later",
                            );
                          }
                        },
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
