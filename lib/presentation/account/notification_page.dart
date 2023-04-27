import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/presentation/account/widgets/cupertino_switch.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AccountAppBar(
          title: 'Notification',
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w,vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StandardText.headline5(
              context,
              'Notify me when',
            ),
            22.verticalSpace,
            AppCupertinoSwitch(
              title: "remind me at bedtime",
              switchValue: true,
              onChangedSwitch: (val){},
            ),
            26.verticalSpace,
            AppCupertinoSwitch(
              title: "set a reminder",
              switchValue: false,
              onChangedSwitch: (val){},
            ),
            26.verticalSpace,
            AppCupertinoSwitch(
              title: "notify me of new drops",
              switchValue: true,
              onChangedSwitch: (val){},
            ),
          ],
        ),
      ),
    );
  }
}
