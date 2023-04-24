import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFound extends StatelessWidget {
  const SearchFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                Image.asset(
                  DropAndGoImages.addictions,
                  width: 73.w,
                  height: 70.h,
                ),
                10.w.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StandardText.headline6(
                      context,
                      "ANXIETY",
                    ),
                    StandardText.button(
                      "Artist Name",
                      fontSize: 10,
                      fontWeight: DropAndGoFontWeight.medium,
                      color: DropAndGoColors.primary.withOpacity(.4),
                      letterSpacing: 0.37.sp,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.favorite_border,),
                )
              ],
            ),
          );
        });
  }
}
