import 'package:dropandgouser/application/complete_profile/cubit/country_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/achievement_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/application/signup/signup_bloc.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/presentation/signup/create_account_form.dart';
import 'package:dropandgouser/presentation/signup/signup_success_dialog.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final UserData? userData;

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupStateError) {
              getIt<Toasts>().showToast(context,
                  type: AlertType.Error,
                  title: 'Error',
                  description: state.message);
            } else if (state is SignupStateCreatedAccount) {
              context.read<UploadPictureSignupBloc>().add(
                    UploadProfilePicture(
                      file: widget.userData!.file!,
                      userId: state.userId,
                    ),
                  );
            }
          },
        ),
        BlocListener<UploadPictureSignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupStateError) {
              getIt<Toasts>().showToast(context,
                  type: AlertType.Error,
                  title: 'Error',
                  description: state.message);
            } else if (state is SignupStateUploadedPicture) {
              UserData userData = UserData(
                id: state.userId,
                email: emailTextEditingController.text,
                phoneNo: widget.userData?.phoneNo,
                fullName: widget.userData?.fullName,
                dateOfBirth: widget.userData?.dateOfBirth,
                gender: context.read<GenderCubit>().state.value,
                ageGroup: context.read<AgeCubit>().state.value,
                country: context.read<CountryCubit>().state,
                level: context.read<UserLevelCubit>().state.title,
                achievement: context.read<AchievementCubit>().state.title,
                profilePicUrl: state.profilePicUrl,
              );
              UserSetting userSetting = UserSetting();
              context.read<PostSignupBloc>().add(
                    UploadUserData(
                      userData: userData,
                      userSetting: userSetting,
                      userId: state.userId,
                    ),
                  );
            }
          },
        ),
        BlocListener<PostSignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupStateError) {
              getIt<Toasts>().showToast(context,
                  type: AlertType.Error,
                  title: 'Error',
                  description: state.message);
            } else if (state is SignupStateUploadedData) {
              SignupSuccessDialog.show(context);
            }
          },
        ),
      ],
      child: BlocBuilder<CreateAccountSettingBloc, SettingState>(
          builder: (context, state) {
        return (state is SettingStateLoading)
            ? const Scaffold(
                body: DropAndGoButtonLoading(),
              )
            : (state is SettingStateLoaded)
                ? Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(70),
                      child: OnboardingAppbar(
                        barValue: 1,
                        onBack: () {
                          getIt<NavigationService>().navigateBack(
                            context: context,
                          );
                        },
                      ),
                    ),
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                      ),
                      child: CreateAccountForm(
                        emailTextEditingController: emailTextEditingController,
                        passwordTextEditingController:
                            passwordTextEditingController,
                        confirmPasswordTextEditingController:
                            confirmPasswordTextEditingController,
                        title: state.setting?.title,
                        subtitle: state.setting?.subtitle,
                        formKey: _formKey,
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
      }),
    );
  }
}
