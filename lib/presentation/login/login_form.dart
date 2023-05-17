import 'package:dropandgouser/application/login/cubit/login_obscurepassword_cubit.dart';
import 'package:dropandgouser/application/login/cubit/login_remember_cubit.dart';
import 'package:dropandgouser/application/login/login_bloc/login_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/login/widgets/orcontinue_text.dart';
import 'package:dropandgouser/presentation/login/widgets/social_buttons.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/extensions/string_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginStateError) {
          getIt<Toasts>().showToast(
            context,
            type: AlertType.Error,
            title: 'Error',
            description: state.message,
          );
        } else if (state is LoginStateLoaded) {
          getIt<NavigationService>().replaceWithNamed(
            context: context,
            uri: NavigationService.homeRouteUri,
          );
        } else if (state is LoggedInWithSocial){
          getIt<NavigationService>().replaceWithNamed(
            context: context,
            uri: NavigationService.homeRouteUri,
          );
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StandardText.headline4(
              context,
              'login.title'.tr(),
            ),
            10.verticalGap,
            StandardText.headline6(
              context,
              'login.subtitle'.tr(),
              align: TextAlign.justify,
            ),
            Container(
              margin: EdgeInsets.only(
                top: context.height * .062,
              ),
              child: StandardText.headline6(
                context,
                'create_account.email'.tr(),
                fontSize: 12,
              ),
            ),
            StandardTextField(
              controller: emailTextEditingController,
              validator: (val) =>
                  val!.isValidEmail() ? null : "Check your email",
              inputFormatter: [
                NoSpaceFormatter(),
              ],
            ),
            25.verticalGap,
            StandardText.headline6(
              context,
              'create_account.password'.tr(),
              fontSize: 12,
            ),
            BlocBuilder<LoginObscurePasswordCubit, bool>(
                builder: (context, isObscure) {
              return Theme(
                data: ThemeData().copyWith(
                  colorScheme: ThemeData().colorScheme.copyWith(
                        primary: DropAndGoColors.primary,
                      ),
                ),
                child: StandardTextField(
                  controller: passwordTextEditingController,
                  obscureText: isObscure,
                  suffixWidget: IconButton(
                    icon: !isObscure
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                    onPressed: () {
                      context.read<LoginObscurePasswordCubit>().onTapped();
                    },
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Password can not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              );
            }),
            18.verticalGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<LoginRememberCubit, bool>(
                    builder: (context, isTrue) {
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
                      context.read<LoginRememberCubit>().onTapped();
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
            53.h.verticalGap,
            // Container(
            //   margin: EdgeInsets.only(
            //     top: context.height * .027,
            //     bottom: context.height * .029,
            //   ),
            //   child: const Divider(
            //     thickness: 1,
            //     color: DropAndGoColors.primary,
            //   ),
            // ),
            InkWell(
              onTap: () {
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.forgetPasswordRouteUri,
                );
              },
              child: Align(
                alignment: Alignment.center,
                child: StandardText.subtitle1(
                  context,
                  'login.forget'.tr(),
                  fontWeight: DropAndGoFontWeight.semiBold,
                ),
              ),
            ),
            const OrContinueText(),
            const SocialButtons(),
            Container(
              height: context.height * .12,
              margin: const EdgeInsets.only(
                top: 28,
                bottom: 43,
              ),
              alignment: Alignment.bottomCenter,
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return (state is LoginStateLoading)
                    ? const DropAndGoButtonLoading()
                    : AppButton(
                        width: context.width,
                        text: 'login.confirm'.tr(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  LoginUser(
                                    email: emailTextEditingController.text,
                                    password:
                                        passwordTextEditingController.text,
                                  ),
                                );
                          }
                        },
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
