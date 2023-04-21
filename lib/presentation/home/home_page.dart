import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.drawer,
            ),
            onPressed: () {},
          ),
          title: Image.asset(
            DropAndGoImages.logo,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                DropAndGoIcons.search,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                DropAndGoIcons.notification,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: context.width - 72.w,
          height: context.height * 0.2.h,
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          decoration: BoxDecoration(
            color: DropAndGoColors.primary,
            borderRadius: BorderRadius.circular(10),
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
                "SELF IMPROVEMENT",
                color: DropAndGoColors.white,
                fontSize: 20,
              ),
              3.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 42.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      DropAndGoIcons.like,
                      color: DropAndGoColors.white,
                    ),
                    SvgPicture.asset(
                      DropAndGoIcons.share,
                      color: DropAndGoColors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
