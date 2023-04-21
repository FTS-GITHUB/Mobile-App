import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: StandardText.headline4(
            context,
            'Explore by Categories',
            color: DropAndGoColors.primary,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 34.w,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child: HomeRectCategory(
              categoryName: index == 0
                  ? "ANXIETY"
                  : index == 1
                      ? "DEPRESSION"
                      : index == 2
                          ? "ADDICTIONS"
                          : index == 3
                              ? "PANIC"
                              : "SELF IMPROVEMENT",
            ),
          );
        },
      ),
    );
  }
}
