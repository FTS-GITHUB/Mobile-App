import 'package:dropandgouser/application/complete_profile/cubit/country_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/rememberme_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/achievement_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/application/signup/signup_bloc.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/signup/signup_success_dialog.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/extensions/string_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/mytoast.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              context.read<PostSignupBloc>().add(
                    UploadUserData(
                      userData: userData,
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

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
    Key? key,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
    required this.confirmPasswordTextEditingController,
    required this.title,
    required this.subtitle,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  final TextEditingController confirmPasswordTextEditingController;
  final String? title;
  final String? subtitle;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StandardText.headline4(context, title ?? ''
              // 'create_account.title'.tr(),
              ),
          10.verticalGap,
          StandardText.headline6(
            context,
            subtitle ?? '',
            // 'onboarding.profile_subtitle'.tr(),
            align: TextAlign.justify,
          ),
          50.verticalGap,
          StandardText.headline6(
            context,
            'create_account.email'.tr(),
            fontSize: 12,
          ),
          StandardTextField(
            controller: emailTextEditingController,
            validator: (val) =>
                 val!.isValidEmail() ? null : "Check your email",
          ),
          25.verticalGap,
          StandardText.headline6(
            context,
            'create_account.password'.tr(),
            fontSize: 12,
          ),
          StandardTextField(
            controller: passwordTextEditingController,
            obscureText: true,
            validator: (val) {
              if (val!.isEmpty || val.length < 8) {
                return 'Password length should be more than 8';
              } else {
                return null;
              }
            },
          ),
          25.verticalGap,
          StandardText.headline6(
            context,
            'create_account.confirm_pas'.tr(),
            fontSize: 12,
          ),
          StandardTextField(
            controller: confirmPasswordTextEditingController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: (val) {
              if (val!.isEmpty || val != passwordTextEditingController.text) {
                return 'Password not matched!';
              }
              return null;
            },
          ),
          18.verticalGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<RememberMeCubit, bool>(builder: (context, isTrue) {
                return Checkbox(
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  activeColor: DropAndGoColors.primary,
                  focusColor: DropAndGoColors.primary,
                  checkColor: DropAndGoColors.white,
                  value: isTrue,
                  onChanged: (val) {
                    context.read<RememberMeCubit>().onTapped();
                  },
                );
              }),
              8.horizontalGap,
              StandardText.headline6(
                context,
                'create_account.remember'.tr(),
              ),
            ],
          ),
          Container(
            height: context.height * .2,
            margin: const EdgeInsets.only(
              top: 28,
              bottom: 43,
            ),
            alignment: Alignment.bottomCenter,
            child:
                BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
              return (state is SignupStateCreatingAccount)
                  ? const DropAndGoButtonLoading()
                  : AppButton(
                      width: context.width,
                      text: 'onboarding.continue'.tr(),
                      isPrefixIcon: false,
                      icon: SvgPicture.asset(
                        DropAndGoIcons.arrowForward,
                      ),
                      onPressed: () {
                        print(formKey.currentState!.validate());
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          context.read<SignupBloc>().add(
                                CreateNewAccount(
                                  email: emailTextEditingController.text,
                                  password: passwordTextEditingController.text,
                                ),
                              );
                        }
                      },
                    );
            }),
          )
        ],
      ),
    );
  }
}
