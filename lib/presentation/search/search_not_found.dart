import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            DropAndGoImages.error,
            width: 309.w,
            height: 309.h,
          ),
          24.h.verticalSpace,
          StandardText.headline4(
            context,
            "NOT FOUND TRY AGAIN",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}