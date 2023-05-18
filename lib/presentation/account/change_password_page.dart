import 'package:dropandgouser/application/account/change_password_bloc/change_password_bloc.dart';
import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
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
    return Scaffold(
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
          child: Column(
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
                obscureText: true,
                controller: oldPasswordTextEditingController,
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
                obscureText: true,
                controller: newPasswordTextEditingController,
                validator: passwordValidation,
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
                obscureText: true,
                controller: confirmPasswordTextEditingController,
                validator: (val) => confirmPasswordValidation(
                  val,
                  password: oldPasswordTextEditingController.text,
                  confirmPassword: newPasswordTextEditingController.text,
                ),
              ),
              BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                builder: (context, state) {
                  return (state is ChangePasswordStateLoading)?
                  const DropAndGoButtonLoading():
                  Container(
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
                                      oldPasswordTextEditingController.text,
                                  newPassword:
                                      newPasswordTextEditingController.text,
                                ),
                              );
                        }
                      },
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  String? passwordValidation(
    String? val,
  ) {
    if (val!.isEmpty || val.length < 7) {
      return 'Please enter strong password to secure your account';
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
      return 'Password & Repeat password does not match';
    } else {
      return null;
    }
  }
}
