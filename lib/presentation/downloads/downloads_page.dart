import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/search/widgets/search_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.arrowLeft,
            ),
            onPressed: () {
              context.read<MainNavBarCubit>().changeBottomNavBar(0);
              getIt<NavigationService>().navigateBack(context: context);
            },
          ),
          title: StandardText.headline2(
            context,
            "Downloads",
            fontSize: 30,
            color: DropAndGoColors.primary,
          ),
        ),
      ),
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: const HomeRectCategory(),
            ),
          ),
          SliverToBoxAdapter(
            child: 37.h.verticalSpace,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: StandardText.headline5(
                context,
                "Liked",
                color: DropAndGoColors.primary,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: 20.h.verticalSpace,
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: 36.w,
                right: 28.w,
              ),
              primary: false,
              itemCount: 12,
              itemBuilder: (context, index) {
                return SearchItem(
                  search: Search(
                    title: "ANXIETY",
                    artistName: "Artist Name",
                    imageUrl: DropAndGoImages.addictions,
                    isFavorite: true,
                    onItemTapped: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
