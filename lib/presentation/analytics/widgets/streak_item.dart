import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StreakItem extends StatelessWidget {
  const StreakItem({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DropAndGoColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(left: 19.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StandardText.headline4(
            context,
            data,
            fontSize: 30,
            color: DropAndGoColors.white,
          ),
          // 4.verticalSpace,
          StandardText.headline6(
            context,
            title,
            fontSize: 12,
            color: DropAndGoColors.white,
          )
        ],
      ),
    );
  }
}
