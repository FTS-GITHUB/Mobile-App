import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/extensions/string_extensions.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.arrowBack,
            ),
            onPressed: () {
              getIt<NavigationService>().navigateBack(context: context);
            },
          ),
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
              StandardText.headline4(
                context,
                'forget.title'.tr(),
              ),
              StandardText.headline6(
                context,
                'forget.subtitle'.tr(),
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
              Container(
                margin: EdgeInsets.only(
                  top: context.height * .458,
                  // bottom: context.height*.005,
                ),
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  width: context.width,
                  text: 'login.confirm'.tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //
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
