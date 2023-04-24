import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFound extends StatelessWidget {
  const SearchFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        primary: false,
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 18),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    DropAndGoImages.addictions,
                    width: 73.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                  ),
                ),
                10.w.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StandardText.headline6(
                      context,
                      "ANXIETY",
                    ),
                    6.h.verticalSpace,
                    StandardText.button(
                      "Artist Name",
                      fontSize: 10,
                      fontWeight: DropAndGoFontWeight.medium,
                      color: DropAndGoColors.primary.withOpacity(.4),
                      letterSpacing: 0.37.sp,
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: SvgPicture.asset(DropAndGoIcons.favoriteOutlined),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
