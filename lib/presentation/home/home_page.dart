import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/category_view_more_header.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/home/widgets/home_square_category.dart';
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
              onPressed: () {
                getIt<NavigationService>().pushNamed(
                  context: context,
                  uri: NavigationService.searchRouteUri,
                );
              },
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: context.width,
          margin: EdgeInsets.only(
            top: 30.h,
            left: 36.w,
            right: 36.w,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeRectCategory(
                isLiked: false,
                onLike: () {
                  print("Liked");
                },
                onShare: () {
                  print("Shared");
                },
              ),
              35.h.verticalSpace,
              CategoryViewMoreHeader(
                onViewMore: () {
                  getIt<NavigationService>().navigateToNamed(
                    context: context,
                    uri: NavigationService.categoriesRouteUri,
                  );
                },
              ),
              20.h.verticalSpace,
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                ),
                itemBuilder: (context, index) {
                  return HomeSquareCategory(
                    categoryName: index == 0 ? "ANXIETY" : null,
                    onTap: () {},
                  );
                },
                itemCount: 4,
              ),
              20.h.verticalSpace,
              CategoryViewMoreHeader(
                categoryName: 'Recommended For You',
                onViewMore: () {
                  getIt<NavigationService>().navigateToNamed(
                    context: context,
                    uri: NavigationService.categoriesRouteUri,
                  );
                },
              ),
              20.h.verticalSpace,
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                ),
                itemBuilder: (context, index) {
                  return HomeSquareCategory(
                    categoryName: index == 0 ? "ANXIETY" : null,
                    onTap: () {},
                  );
                },
                itemCount: 2,
              ),
              20.h.verticalSpace,
              CategoryViewMoreHeader(
                categoryName: 'For Better Sleep',
                onViewMore: () {
                  getIt<NavigationService>().navigateToNamed(
                    context: context,
                    uri: NavigationService.categoriesRouteUri,
                  );
                },
              ),
              20.h.verticalSpace,
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                ),
                itemBuilder: (context, index) {
                  return HomeSquareCategory(
                    categoryName: index == 0 ? "ANXIETY" : null,
                    onTap: () {},
                  );
                },
                itemCount: 4,
              ),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
