import 'package:dropandgouser/shared/animations/fade_animation.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSquareCategory extends StatelessWidget {
  const HomeSquareCategory({
    Key? key,
    this.categoryName,
    this.onTap,
    required this.imageUrl,
  }) : super(key: key);

  final String? categoryName;
  final VoidCallback? onTap;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 152.w,
          height: 144.h,
          padding: EdgeInsets.only(
            bottom: 15.h,
          ),
          decoration: BoxDecoration(
            color: DropAndGoColors.primary,
            borderRadius: BorderRadius.circular(10.h),
            image: DecorationImage(
              image: NetworkImage(
                imageUrl,
              ),
              fit: BoxFit.cover,
              colorFilter: DropAndGoColors.appColorFilter,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StandardText.headline4(
                context,
                categoryName ?? 'ADDICTIONS',
                align: TextAlign.center,
                color: DropAndGoColors.white,
                fontSize: 20.sp,
              ),
              3.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
