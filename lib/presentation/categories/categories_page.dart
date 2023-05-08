import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/home/category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

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
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 34.w,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child: HomeRectCategory(
              imageUrl: categories[index].imageUrl,
              categoryName: categories[index].name??'',
              onTap: () {
                getIt<NavigationService>().navigateToNamed(
                  context: context,
                  uri: NavigationService.categoryDetailRouteUri,
                  data: categories[index].id,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
