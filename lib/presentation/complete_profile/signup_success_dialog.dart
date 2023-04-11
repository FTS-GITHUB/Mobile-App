import 'package:dropandgouser/presentation/complete_profile/widgets/success_placeholder.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_dialog.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignupSuccessDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      barrierColor: DropAndGoColors.transparent,
      context: context,
      builder: (context) => AppDialog(
        header: const SuccessPlaceholder(),
        title: 'create_account.success'.tr(),
        description: 'onboarding.profile_subtitle'.tr(),
        actions: const [
          DropAndGoButtonLoading(),
        ],
      ),
    );
  }
}
