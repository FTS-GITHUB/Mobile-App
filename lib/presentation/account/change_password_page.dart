import 'package:dropandgouser/application/account/change_password_bloc/change_password_bloc.dart';
import 'package:dropandgouser/application/account/change_password_cubit/change_password_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordTextEditingController =
      TextEditingController();
  TextEditingController newPasswordTextEditingController =
      TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPasswordTextEditingController.dispose();
    newPasswordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordStateError) {
          getIt<Toasts>().showToast(
            context,
            type: AlertType.Error,
            title: 'Error',
            description: state.message,
          );
        } else if (state is ChangePasswordStateLoaded) {
          getIt<NavigationService>().navigateToNamed(
            context: context,
            uri: NavigationService.loginRouteUri,
          );
          getIt<Toasts>().showToast(
            context,
            type: AlertType.Success,
            title: 'Success',
            description: "Password changed successfully, login again to continue",
          );
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AccountAppBar(
            title: 'change_pw.title'.tr(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          child: Form(
            key: _formKey,
            child: BlocBuilder<ChangePasswordCubit, ChangePasswordCubitState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: context.height * .062,
                      ),
                      child: StandardText.headline6(
                        context,
                        'change_pw.old'.tr(),
                        fontSize: 12,
                      ),
                    ),
                    StandardTextField(
                      obscureText: state.isOldPasswordObscure,
                      controller: oldPasswordTextEditingController,
                      suffixWidget: IconButton(
                        icon: !state.isOldPasswordObscure
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          context
                              .read<ChangePasswordCubit>()
                              .onOldPasswordTapped();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: context.height * .062,
                      ),
                      child: StandardText.headline6(
                        context,
                        'change_pw.new'.tr(),
                        fontSize: 12,
                      ),
                    ),
                    StandardTextField(
                      obscureText: state.isNewPasswordObscure,
                      controller: newPasswordTextEditingController,
                      validator: (val) => passwordValidation(
                        oldPasswordTextEditingController.text,
                        newPasswordTextEditingController.text,
                      ),
                      suffixWidget: IconButton(
                        icon: !state.isNewPasswordObscure
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          context
                              .read<ChangePasswordCubit>()
                              .onNewPasswordTapped();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: context.height * .062,
                      ),
                      child: StandardText.headline6(
                        context,
                        'change_pw.confirm'.tr(),
                        fontSize: 12,
                      ),
                    ),
                    StandardTextField(
                      obscureText: state.isConfirmNewPasswordObscure,
                      controller: confirmPasswordTextEditingController,
                      validator: (val) => confirmPasswordValidation(
                        val,
                        password: newPasswordTextEditingController.text,
                        confirmPassword:
                            confirmPasswordTextEditingController.text,
                      ),
                      suffixWidget: IconButton(
                        icon: !state.isConfirmNewPasswordObscure
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          context
                              .read<ChangePasswordCubit>()
                              .onConfirmNewPasswordTapped();
                        },
                      ),
                    ),
                    BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                        builder: (context, state) {
                      return (state is ChangePasswordStateLoading)
                          ? const DropAndGoButtonLoading()
                          : Container(
                              margin: EdgeInsets.only(
                                top: context.height * .358,
                                // bottom: context.height*.005,
                              ),
                              alignment: Alignment.bottomCenter,
                              child: AppButton(
                                width: context.width,
                                text: 'login.confirm'.tr(),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ChangePasswordBloc>().add(
                                          UpdatePassword(
                                            oldPassword:
                                                oldPasswordTextEditingController
                                                    .text,
                                            newPassword:
                                                newPasswordTextEditingController
                                                    .text,
                                          ),
                                        );
                                  }
                                },
                              ),
                            );
                    })
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? passwordValidation(
    String? val,
    String? newPassword,
  ) {
    if (val!.isEmpty || val.length < 7) {
      return 'Please enter strong password to secure your account';
    } else if (val == newPassword) {
      return 'New password must be different from old';
    } else {
      return null;
    }
  }

  String? confirmPasswordValidation(
    String? val, {
    required String password,
    required String confirmPassword,
  }) {
    if (val!.isEmpty) {
      return 'Please enter your password again';
    } else if (password != confirmPassword) {
      return 'New password & confirm password not matched';
    } else {
      return null;
    }
  }
}
