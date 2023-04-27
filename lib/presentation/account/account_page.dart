import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/widgets/account_list_tile.dart';
import 'package:dropandgouser/presentation/account/widgets/profile_tile.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.arrowLeft,
            ),
            onPressed: () {
              context.read<MainNavBarCubit>().changeBottomNavBar(0);
              getIt<NavigationService>().navigateBack(context: context);
            },
          ),
          title: StandardText.headline4(
            context,
            "Account",
            fontSize: 30.sp,
            color: DropAndGoColors.primary,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          children: [
            const ProfileTile(),
            20.verticalSpace,
            AccountListTile(
              avatarColor: DropAndGoColors.purple,
              title: 'Personal Info',
              iconUrl: DropAndGoIcons.userBold,
              onTap: (){},
            ),
            AccountListTile(
              avatarColor: DropAndGoColors.blue,
              title: 'Notification',
              iconUrl: DropAndGoIcons.notificationBold,
              onTap: (){},
            ),
            AccountListTile(
              avatarColor: DropAndGoColors.green,
              title: 'Preference',
              iconUrl: DropAndGoIcons.setting,
              onTap: (){},
            ),
            AccountListTile(
              avatarColor: DropAndGoColors.yellow,
              title: 'Security',
              iconUrl: DropAndGoIcons.shieldTick,
              onTap: (){},
            ),
            AccountListTile(
              avatarColor: DropAndGoColors.orange,
              title: 'Language',
              iconUrl: DropAndGoIcons.language,
              onTap: (){},
            ),
            25.verticalSpace,
            Divider(
              height: 1,
              color: DropAndGoColors.primary,
            ),
            20.verticalSpace,
            AccountListTile(
              avatarColor: DropAndGoColors.primary,
              title: 'Log out',
              iconUrl: DropAndGoIcons.logout,
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
