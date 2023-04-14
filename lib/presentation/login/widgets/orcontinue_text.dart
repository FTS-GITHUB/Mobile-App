import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrContinueText extends StatelessWidget {
  const OrContinueText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height*.036,
        bottom: context.height*.02,
      ),
      child: Row(
        children: [
          const Flexible(
            flex: 3,
            child: Divider(
              thickness: 1,
              color: DropAndGoColors.primary,
            ),
          ),
          Flexible(
            flex: 5,
            child: StandardText.subtitle2(
              context,
              'login.or'.tr(),
            ),
          ),
          const Flexible(
            flex: 3,
            child: Divider(
              thickness: 1,
              color: DropAndGoColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
