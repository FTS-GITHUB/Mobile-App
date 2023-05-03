import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/category_detail/widgets/song_item.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/search/widgets/search_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({
    required this.categoryTitle,
    Key? key,
  }) : super(key: key);

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: StandardText.headline4(
            context,
            categoryTitle,
            color: DropAndGoColors.black,
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.arrowLeft,
            ),
            onPressed: () {
              getIt<NavigationService>().navigateBack(
                context: context,
              );
            },
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeRectCategory(
                categoryName: 'ANXIETY',
                height: 247.h,
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  DropAndGoIcons.favoriteFilled,
                ),
              ),
              30.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return SongItem(
                    onTap: () {
                      getIt<NavigationService>().pushNamed(
                        context: context,
                        uri: NavigationService.plyaerAudioRouteUri,
                        data: index.toString(),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
