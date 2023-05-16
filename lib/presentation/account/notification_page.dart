import 'package:dropandgouser/application/account/account_cubit/remind_bedtime_cubit.dart';
import 'package:dropandgouser/application/account/account_cubit/set_reminder_cubit.dart';
import 'package:dropandgouser/application/account/account_setting_bloc/account_setting_bloc.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/presentation/account/widgets/app_switch.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserSetting? setting = getIt<UserService>().userSetting;
    context
        .read<RemindBedTimeCubit>()
        .initialize(setting?.isRemindBedtime ?? true);
    context.read<SetReminderCubit>().initialize(setting?.isSetReminder ?? true);
    return BlocListener<AccountSettingBloc, AccountSettingState>(
      listener: (context, state) {
        if (state is AccountSettingStateLoaded) {
          getIt<NavigationService>().navigateBack(
            context: context,
          );
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AccountAppBar(
            title: 'Notification',
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StandardText.headline5(
                context,
                'Notify me when',
              ),
              22.verticalSpace,
              BlocBuilder<RemindBedTimeCubit, bool>(
                  builder: (context, isRemindAtBedtime) {
                return AppSwitch(
                  title: "remind me at bedtime",
                  switchValue: isRemindAtBedtime,
                  onChangedSwitch:
                      context.read<RemindBedTimeCubit>().initialize,
                );
              }),
              26.verticalSpace,
              BlocBuilder<SetReminderCubit, bool>(
                  builder: (context, isSetReminder) {
                return AppSwitch(
                  title: "set a reminder",
                  switchValue: isSetReminder,
                  onChangedSwitch: context.read<SetReminderCubit>().initialize,
                );
              }),
              26.verticalSpace,
              // AppSwitch(
              //   title: "notify me of new drops",
              //   switchValue: true,
              //   onChangedSwitch: (val){},
              // ),
              Container(
                margin: const EdgeInsets.only(
                  top: 28,
                  bottom: 43,
                ),
                alignment: Alignment.bottomCenter,
                child: BlocBuilder<AccountSettingBloc, AccountSettingState>(
                    builder: (context, state) {
                  return (state is AccountSettingStateLoading)
                      ? const DropAndGoButtonLoading()
                      : AppButton(
                          width: context.width,
                          text: 'login.confirm'.tr(),
                          onPressed: () {
                            setting = setting?.copyWith(
                              isRemindBedtime:
                                  context.read<RemindBedTimeCubit>().state,
                              isSetReminder:
                                  context.read<SetReminderCubit>().state,
                            );
                            context.read<AccountSettingBloc>().add(
                                  UpdateUserSetting(
                                    userSetting: setting!,
                                  ),
                                );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
