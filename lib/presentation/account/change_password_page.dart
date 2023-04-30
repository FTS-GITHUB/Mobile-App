import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        preferredSize: const  Size.fromHeight(50),
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
                controller: newPasswordTextEditingController,
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
                controller: confirmPasswordTextEditingController,
              ),
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
                      debugPrint('Chang ed.');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}