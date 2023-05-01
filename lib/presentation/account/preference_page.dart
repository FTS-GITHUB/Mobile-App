import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/presentation/account/widgets/icon_forward.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/app_switch.dart';

class PreferencePage extends StatelessWidget {
  const PreferencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AccountAppBar(
          title: 'Preference',
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w,vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StandardText.headline5(
              context,
              'General',
              fontSize: 20,
              fontWeight: DropAndGoFontWeight.semiBold,
            ),
            30.verticalSpace,
            AppSwitch(
              title: "Download over WIFI only",
              isUpperCase: false,
              switchValue: true,
              onChangedSwitch: (val){},
              switchColor: DropAndGoColors.lightGreen,
            ),
            25.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StandardText.headline6(
                  context,
                  'Clear Cache',
                ),
                const IconForward(),
              ],
            ),
            30.verticalSpace,
            StandardText.headline5(
              context,
              'Audio',
            ),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StandardText.headline6(
                  context,
                  'Audio Quality',
                ),
                Row(
                  children: [
                    StandardText.headline6(
                      context,
                      'Standard',
                    ),
                    const IconForward(),
                  ],
                ),
              ],
            ),
            30.verticalSpace,
            AppSwitch(
              title: "Automatically Download Audio",
              isUpperCase: false,
              switchValue: false,
              onChangedSwitch: (val){},
              switchColor: DropAndGoColors.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}
