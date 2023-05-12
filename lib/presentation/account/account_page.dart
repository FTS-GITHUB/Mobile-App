import 'package:dropandgouser/application/home/user_bloc/user_bloc.dart';
import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/logout_bottom_sheet.dart';
import 'package:dropandgouser/presentation/account/widgets/account_list_tile.dart';
import 'package:dropandgouser/presentation/account/widgets/profile_tile.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
            "account.title".tr(),
            fontSize: 30.sp,
            color: DropAndGoColors.primary,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          children: [
            const ProfileTile(),
            20.verticalSpace,
            AccountListTile(
              avatarColor: DropAndGoColors.purple,
              title: 'account.info'.tr(),
              iconUrl: DropAndGoIcons.userBold,
              onTap: () {
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.personalInfoRouteUri,
                );
              },
            ),
            AccountListTile(
              avatarColor: DropAndGoColors.blue,
              title: 'account.notification'.tr(),
              iconUrl: DropAndGoIcons.notificationBold,
              onTap: () {
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.notificationRouteUri,
                );
              },
            ),
            AccountListTile(
              avatarColor: DropAndGoColors.green,
              title: 'account.pref'.tr(),
              iconUrl: DropAndGoIcons.setting,
              onTap: () {
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.preferenceRouteUri,
                );
              },
            ),
            AccountListTile(
              avatarColor: DropAndGoColors.yellow,
              title: 'account.security'.tr(),
              iconUrl: DropAndGoIcons.shieldTick,
              onTap: () {
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.securityRouteUri,
                );
              },
            ),
            // AccountListTile(
            //   avatarColor: DropAndGoColors.orange,
            //   title: 'Language',
            //   iconUrl: DropAndGoIcons.language,
            //   onTap: (){},
            // ),
            25.verticalSpace,
            const Divider(
              height: 1,
              color: DropAndGoColors.primary,
            ),
            20.verticalSpace,
            AccountListTile(
              avatarColor: DropAndGoColors.primary,
              title: 'account.logout'.tr(),
              iconUrl: DropAndGoIcons.logout,
              onTap: () {
                showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (ctx) => const LogoutBottomSheet(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
