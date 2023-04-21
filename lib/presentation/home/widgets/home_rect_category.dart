import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeRectCategory extends StatelessWidget {
  const HomeRectCategory({
    Key? key,
    this.categoryName = 'SELF IMPROVEMENT',
    this.isLiked=false,
    this.onLike,
    this.onShare,
    this.onTap,
  }) : super(key: key);

  final String categoryName;
  final bool isLiked;
  final VoidCallback? onLike;
  final VoidCallback? onShare;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        height: context.height * 0.2.h,
        padding: EdgeInsets.only(
          bottom: 15.h,
        ),
        decoration: BoxDecoration(
          color: DropAndGoColors.primary,
          borderRadius: BorderRadius.circular(10.h),
          image: DecorationImage(
            image: const AssetImage(
              DropAndGoImages.defaultCategory,
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
              categoryName,
              color: DropAndGoColors.white,
              align: TextAlign.center,
              fontSize: 20.sp,
            ),
            3.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 42.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onLike,
                    child: isLiked?
                    SvgPicture.asset(
                      DropAndGoIcons.likeFilled,
                    ):
                    SvgPicture.asset(
                      DropAndGoIcons.like,
                    ),
                  ),
                  InkWell(
                    onTap: onShare,
                    child: SvgPicture.asset(
                      DropAndGoIcons.share,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}