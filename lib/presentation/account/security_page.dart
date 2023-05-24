import 'package:dropandgouser/application/account/account_cubit/biometric_id_cubit.dart';
import 'package:dropandgouser/application/account/account_cubit/face_id_cubit.dart';
import 'package:dropandgouser/application/account/account_setting_bloc/account_setting_bloc.dart';
import 'package:dropandgouser/application/complete_profile/cubit/rememberme_cubit.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/presentation/account/widgets/app_switch.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({Key? key}) : super(key: key);

  initializeSecurityValues(
    BuildContext context,
    UserSetting? setting,
  ) {
    context.read<RememberMeCubit>().initialize(setting?.isRemember ?? true);
    context.read<BiometricCubit>().initialize(setting?.isBiometric ?? false);
    context.read<FaceIdCubit>().initialize(setting?.isFaceId ?? true);
  }

  @override
  Widget build(BuildContext context) {
    UserData? userData = getIt<UserService>().userData;
    UserSetting? setting = getIt<UserService>().userSetting;
    initializeSecurityValues(context, setting);
    return BlocListener<AccountSettingBloc, AccountSettingState>(
      listener: (securityContext, state){
        if(state is AccountSettingStateLoaded){
          getIt<NavigationService>().navigateBack(context: securityContext);
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AccountAppBar(
            title: 'Security',
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            children: [
              BlocBuilder<RememberMeCubit, bool>(
                  builder: (context, isRememberMe) {
                return AppSwitch(
                  title: "Remember me",
                  isUpperCase: false,
                  switchValue: isRememberMe,
                  onChangedSwitch: context.read<RememberMeCubit>().initialize,
                  switchColor: DropAndGoColors.yellow,
                );
              }),
              30.verticalSpace,
              BlocBuilder<BiometricCubit, bool>(
                  builder: (context, isBiometricId) {
                return AppSwitch(
                  title: "Biometric e.g Face ID, Fingerprint",
                  isUpperCase: false,
                  switchValue: isBiometricId,
                  onChangedSwitch: context.read<BiometricCubit>().initialize,
                  switchColor: DropAndGoColors.yellow,
                );
              }),
              30.verticalSpace,
              // BlocBuilder<FaceIdCubit, bool>(builder: (context, isFaceId) {
              //   return AppSwitch(
              //     title: "Face ID",
              //     isUpperCase: false,
              //     switchValue: isFaceId,
              //     onChangedSwitch: context.read<FaceIdCubit>().initialize,
              //     switchColor: DropAndGoColors.yellow,
              //   );
              // }),
              50.verticalSpace,
              Visibility(
                visible: userData?.signInMethod==null,
                child: AppButton(
                  text: 'Change Password',
                  width: context.width,
                  color: DropAndGoColors.white,
                  enableColor: DropAndGoColors.primary,
                  onPressed: () {
                    getIt<NavigationService>().pushNamed(
                      context: context,
                      uri: NavigationService.changePasswordRouteUri,
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 45,
                  bottom: 43,
                ),
                alignment: Alignment.bottomCenter,
                child: BlocBuilder<AccountSettingBloc, AccountSettingState>(
                  builder: (context, state) {
                    return (state is AccountSettingStateLoading)?
                    const DropAndGoButtonLoading():
                    AppButton(
                      width: context.width,
                      text: 'login.confirm'.tr(),
                      onPressed: () {
                        setting = setting?.copyWith(
                          isRemember: context.read<RememberMeCubit>().state,
                          isBiometric: context.read<BiometricCubit>().state,
                          isFaceId: context.read<FaceIdCubit>().state,
                        );
                        context.read<AccountSettingBloc>().add(
                              UpdateUserSetting(userSetting: setting!),
                            );
                      },
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
