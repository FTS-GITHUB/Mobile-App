import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          minRadius: 35.h,
          backgroundColor: Colors.red,
        ),
        8.horizontalSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StandardText.headline6(
              context,
              'Mark Smith',
              fontWeight: DropAndGoFontWeight.bold,
            ),
            4.verticalSpace,
            StandardText.headline6(
              context,
              'marksmith765400@gmail.com',
              fontSize: 10,
              fontWeight: DropAndGoFontWeight.medium,
            ),
          ],
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (){
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
