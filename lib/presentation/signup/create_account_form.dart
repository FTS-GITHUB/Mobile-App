import 'package:dropandgouser/application/complete_profile/cubit/rememberme_cubit.dart';
import 'package:dropandgouser/application/signup/signup_bloc.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/extensions/string_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/constants/assets.dart';

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