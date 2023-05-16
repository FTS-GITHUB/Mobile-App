import 'package:dropandgouser/application/login/login_bloc/login_bloc.dart';
import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          getIt<NavigationService>().navigateToNamed(
            context: context,
            uri: NavigationService.loginRouteUri,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        height: context.height * .3,
        decoration: const BoxDecoration(
          color: DropAndGoColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h, bottom: 13.h),
              decoration: BoxDecoration(
                color: DropAndGoColors.white,
                borderRadius: BorderRadius.circular(3),
              ),
              height: 3.h,
              width: 54,
            ),
            StandardText.headline4(
              context,
              'account.logout'.tr(),
              color: DropAndGoColors.white,
            ),
            17.verticalSpace,
            const Divider(
              color: DropAndGoColors.white,
            ),
            30.verticalSpace,
            StandardText.headline4(
              context,
              'account.logout_desc'.tr(),
              color: DropAndGoColors.white,
              fontSize: 20,
              fontWeight: DropAndGoFontWeight.medium,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                  bottom: 18.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        color: DropAndGoColors.grey.withOpacity(.3),
                        text: 'account.cancel'.tr(),
                        onPressed: () {
                          getIt<NavigationService>()
                              .navigateBack(context: context);
                        },
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                        return AppButton(
                          isLoading: state is LoginStateLoading,
                          color: DropAndGoColors.grey.withOpacity(.3),
                          text: 'account.yes_log'.tr(),
                          onPressed: () {
                            context
                                .read<MainNavBarCubit>()
                                .changeBottomNavBar(0);
                            context.read<LoginBloc>().add(LogoutUser());
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
