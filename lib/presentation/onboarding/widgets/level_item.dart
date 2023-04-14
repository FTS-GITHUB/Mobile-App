import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LevelItem extends StatelessWidget {
  const LevelItem({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0.h),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
        tileColor: DropAndGoColors.primary,
        contentPadding:
        EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w, right: 4.w),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.w),
          child: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outlined,
            color: DropAndGoColors.white,
          ),
        ),
        minLeadingWidth: 10.w,
        title: StandardText.headline6(
          context,
          title,
          color: DropAndGoColors.white,
        ),
      ),
    );
  }
}