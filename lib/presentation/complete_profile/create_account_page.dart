import 'package:dropandgouser/application/complete_profile/cubit/rememberme_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/complete_profile/signup_success_dialog.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountSettingBloc, SettingState>(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StandardText.headline4(
                            context, state.setting?.title ?? ''
                            // 'create_account.title'.tr(),
                            ),
                        10.verticalGap,
                        StandardText.headline6(
                          context,
                          state.setting?.subtitle ?? '',
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
                          // controller: nameTextEditingController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please write your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        25.verticalGap,
                        StandardText.headline6(
                          context,
                          'create_account.password'.tr(),
                          fontSize: 12,
                        ),
                        StandardTextField(
                          // controller: nameTextEditingController,
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
                          // controller: nameTextEditingController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            if (val!.isEmpty || val.length < 8) {
                              // return 'Password length should be more than 8';
                            }
                            return null;
                          },
                        ),
                        18.verticalGap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<RememberMeCubit, bool>(
                                builder: (context, isTrue) {
                              return Checkbox(
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
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
                          child: AppButton(
                            width: context.width,
                            text: 'onboarding.continue'.tr(),
                            isPrefixIcon: false,
                            icon: SvgPicture.asset(
                              DropAndGoIcons.arrowForward,
                            ),
                            onPressed: () {
                              SignupSuccessDialog.show(context);
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
