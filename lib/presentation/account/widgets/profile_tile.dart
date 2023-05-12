import 'package:dropandgouser/application/account/personal_info_bloc/personal_info_bloc.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = getIt<UserService>().userData;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: user?.profilePicUrl == null
              ? CircleAvatar(
            minRadius: 35.h,
                  backgroundColor: DropAndGoColors.primary,
                  child: SvgPicture.asset(
                    DropAndGoIcons.userBold,
                  ),
                )
              : Image.network(
                  user!.profilePicUrl!,
                  width: 70.h,
                  height: 70.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) {
                    return CircleAvatar(
                      minRadius: 35.h,
                      backgroundColor: DropAndGoColors.primary,
                      child: SvgPicture.asset(
                        DropAndGoIcons.userBold,
                      ),
                    );
                  },
                ),
        ),
        8.horizontalSpace,
        BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
          builder: (context, state) {
            return (state is PersonalInfoStateLoading)?
            const DropAndGoButtonLoading():
            (state is PersonalInfoStateLoaded)?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StandardText.headline6(
                  context,
                  state.userData.fullName ?? 'N/A',
                  fontWeight: DropAndGoFontWeight.bold,
                ),
                4.verticalSpace,
                StandardText.headline6(
                  context,
                  user?.email ?? 'N/A',
                  fontSize: 10,
                  fontWeight: DropAndGoFontWeight.medium,
                ),
              ],
            ):
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StandardText.headline6(
                  context,
                  user?.fullName ?? 'N/A',
                  fontWeight: DropAndGoFontWeight.bold,
                ),
                4.verticalSpace,
                StandardText.headline6(
                  context,
                  user?.email ?? 'N/A',
                  fontSize: 10,
                  fontWeight: DropAndGoFontWeight.medium,
                ),
              ],
            );
          }
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.personalInfoRouteUri,
                );
              },
              child: SvgPicture.asset(
                DropAndGoIcons.edit,
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
