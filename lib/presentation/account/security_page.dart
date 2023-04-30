import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/presentation/account/widgets/app_switch.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AccountAppBar(
          title: 'Security',
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w,vertical: 10.h),
        child: Column(
          children: [
            AppSwitch(
              title: "Remember me",
              isUpperCase: false,
              switchValue: true,
              onChangedSwitch: (val){},
              switchColor: DropAndGoColors.yellow,
            ),
            30.verticalSpace,
            AppSwitch(
              title: "Biometric ID",
              isUpperCase: false,
              switchValue: true,
              onChangedSwitch: (val){},
              switchColor: DropAndGoColors.yellow,
            ),
            30.verticalSpace,
            AppSwitch(
              title: "Face ID",
              isUpperCase: false,
              switchValue: true,
              onChangedSwitch: (val){},
              switchColor: DropAndGoColors.yellow,
            ),
            50.verticalSpace,
            AppButton(
              text: 'Change Password',
              width: context.width,
              onPressed: (){
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.changePasswordRouteUri,
                );
                print('change password');
              },
            ),
          ],
        ),
      ),
    );
  }
}
