import 'dart:math';

import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    Key? key,
    required this.avatarColor,
    required this.title,
    this.onTap
  }) : super(key: key);

  final Color avatarColor;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
      onTap: onTap,
      leading: CircleAvatar(
        radius: 22,
        // minRadius: 30.h,
        backgroundColor: avatarColor,
        child: const Icon(
          Icons.person,
          color: DropAndGoColors.white,
        ),
      ),
      title: StandardText.headline5(
        context,
        title,
        fontSize: 20.sp,
      ),
      trailing: Transform.rotate(
        angle: pi,
        child: SvgPicture.asset(
          DropAndGoIcons.arrowLeft,
        ),
      ),
    );
  }
}
