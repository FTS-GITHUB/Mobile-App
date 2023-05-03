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
    this.isLiked = false,
    this.onLike,
    this.onShare,
    this.onTap,
    this.height,
    this.imageUrl,
  }) : super(key: key);

  final String categoryName;
  final bool isLiked;
  final VoidCallback? onLike;
  final VoidCallback? onShare;
  final VoidCallback? onTap;
  final double? height;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        height: height ?? context.height * 0.2.h,
        padding: EdgeInsets.only(
          bottom: 15.h,
        ),
        decoration: BoxDecoration(
          color: DropAndGoColors.primary,
          borderRadius: BorderRadius.circular(10.h),
          image: DecorationImage(
            image: AssetImage(
              imageUrl?? DropAndGoImages.defaultCategory,
            ),
            fit: BoxFit.cover,
            colorFilter: DropAndGoColors.appColorFilter,
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment:
              height == null ? MainAxisAlignment.end : MainAxisAlignment.center,
          children: [
            StandardText.headline4(
              context,
              categoryName,
              color: DropAndGoColors.white,
              align: TextAlign.center,
              fontSize: height == null ? 20.sp : 30.sp,
            ),
            if(height == null)
            3.verticalSpace,
            height == null
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 42.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: onLike,
                          child: isLiked
                              ? SvgPicture.asset(
                                  DropAndGoIcons.likeFilled,
                                )
                              : SvgPicture.asset(
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
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
