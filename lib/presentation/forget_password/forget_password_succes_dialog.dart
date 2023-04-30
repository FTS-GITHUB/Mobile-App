import 'package:dropandgouser/application/login/login_bloc/login_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/signup/widgets/success_placeholder.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_dialog.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordSuccessDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      barrierColor: DropAndGoColors.transparent,
      context: context,
      builder: (context) =>
          BlocListener<ForgetPasswordBloc, LoginState>(
            listener: (context, forgetPasswordState) {
              if (forgetPasswordState is LoginStateError) {
                getIt<NavigationService>().navigateBack(context: context);
                getIt<Toasts>().showToast(context, type: AlertType.Error,
                  title: 'Error',
                  description: forgetPasswordState.message,
                );
              }
            },
            child: BlocBuilder<ForgetPasswordBloc, LoginState>(
                builder: (context, forgetPasswordState) {
                  return (forgetPasswordState is ForgetPasswordSendingEmail)
                      ? const AppDialog(
                    actions: [
                      DropAndGoButtonLoading(),
                    ],
                  )
                      : (forgetPasswordState is ForgetPasswordSentEmail)
                      ? const AppDialog(
                    header: SuccessPlaceholder(),
                    title: 'Reset Password Successful',
                    description: 'Email successfully sent, please check your inbox',
                  )
                      : (forgetPasswordState is LoginStateError)
                      ? AppDialog(
                    title: "Error",
                    description: forgetPasswordState.message,
                  )
                      : const SizedBox.shrink();
                }),
          ),
    );
  }
}