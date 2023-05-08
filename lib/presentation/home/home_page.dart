import 'package:dropandgouser/application/home/home_bloc/home_bloc.dart';
import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/category_view_more_header.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/home/widgets/home_square_category.dart';
import 'package:dropandgouser/shared/animations/slide_animation.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../application/home/user_bloc/user_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchUser());
    context.read<HomeBloc>().add(FetchCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: false,
          title: Transform.scale(
            scale: .8,
            child: Image.asset(
              DropAndGoImages.logo,
            ),
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
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserStateLoaded) {
                debugPrint("User Name: ${state.userData.fullName}");
                debugPrint(
                    "Liked Categories: ${state.userData.likedCategories}");
              }
            },
            child:
                BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
              return BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                return (state is HomeStateLoading)
                    ? const DropAndGoButtonLoading()
                    : (state is HomeStateLoaded)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              userState is UserStateLoading
                                  ? const SizedBox.shrink()
                                  : userState is UserStateLoaded
                                      ? Visibility(
                                          visible:
                                              state.randomCategory.name != null,
                                          child: HomeRectCategory(
                                            categoryName:
                                                state.randomCategory.name,
                                            imageUrl:
                                                state.randomCategory.imageUrl,
                                            isLiked: userState.userData
                                                            .likedCategories !=
                                                        null &&
                                                    userState.userData
                                                        .likedCategories!
                                                        .contains(state
                                                            .randomCategory.id!)
                                                ? true
                                                : false,
                                            onLike: () {},
                                            onShare: () {},
                                            onTap: () {
                                              getIt<NavigationService>()
                                                  .navigateToNamed(
                                                context: context,
                                                uri: NavigationService
                                                    .categoryDetailRouteUri,
                                                data: state.randomCategory.name,
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                              35.h.verticalSpace,
                              SlideInAnimation(
                                child: CategoryViewMoreHeader(
                                  onViewMore: () {
                                    getIt<NavigationService>().navigateToNamed(
                                      context: context,
                                      uri: NavigationService.categoriesRouteUri,
                                    );
                                  },
                                ),
                              ),
                              20.h.verticalSpace,
                              GridView.builder(
                                primary: false,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 22,
                                  mainAxisSpacing: 22,
                                ),
                                itemBuilder: (context, index) {
                                  Category category =
                                      state.allCategories[index];
                                  return HomeSquareCategory(
                                    imageUrl: category.imageUrl ?? '',
                                    categoryName: category.name,
                                    onTap: () {
                                      getIt<NavigationService>()
                                          .navigateToNamed(
                                        context: context,
                                        uri: NavigationService
                                            .categoryDetailRouteUri,
                                        data: category.name,
                                      );
                                    },
                                  );
                                },
                                itemCount: state.allCategories.length > 4
                                    ? 4
                                    : state.allCategories.length,
                              ),
                              20.h.verticalSpace,
                              SlideInAnimation(
                                child: CategoryViewMoreHeader(
                                  categoryName: 'Recommended For You',
                                  onViewMore: () {
                                    getIt<NavigationService>().navigateToNamed(
                                      context: context,
                                      uri: NavigationService.categoriesRouteUri,
                                    );
                                  },
                                ),
                              ),
                              20.h.verticalSpace,
                              GridView.builder(
                                primary: false,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 22,
                                  mainAxisSpacing: 22,
                                ),
                                itemBuilder: (context, index) {
                                  Category category =
                                      state.recommendedCategories[index];
                                  return HomeSquareCategory(
                                    imageUrl: category.imageUrl ?? '',
                                    categoryName: category.name,
                                    onTap: () {
                                      getIt<NavigationService>()
                                          .navigateToNamed(
                                        context: context,
                                        uri: NavigationService
                                            .categoryDetailRouteUri,
                                        data: category.name,
                                      );
                                    },
                                  );
                                },
                                itemCount:
                                    state.recommendedCategories.length > 2
                                        ? 2
                                        : state.recommendedCategories.length,
                              ),
                              20.h.verticalSpace,
                              SlideInAnimation(
                                child: CategoryViewMoreHeader(
                                  categoryName: 'For Better Sleep',
                                  onViewMore: () {
                                    getIt<NavigationService>().navigateToNamed(
                                      context: context,
                                      uri: NavigationService.categoriesRouteUri,
                                    );
                                  },
                                ),
                              ),
                              20.h.verticalSpace,
                              GridView.builder(
                                primary: false,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 22,
                                  mainAxisSpacing: 22,
                                ),
                                itemBuilder: (context, index) {
                                  Category category =
                                      state.forBetterSleepCategories[index];
                                  return HomeSquareCategory(
                                    imageUrl: category.imageUrl ?? '',
                                    categoryName: category.name,
                                    onTap: () {
                                      getIt<NavigationService>()
                                          .navigateToNamed(
                                        context: context,
                                        uri: NavigationService
                                            .categoryDetailRouteUri,
                                        data: category.name,
                                      );
                                    },
                                  );
                                },
                                itemCount:
                                    state.forBetterSleepCategories.length > 4
                                        ? 4
                                        : state.forBetterSleepCategories.length,
                              ),
                              15.verticalSpace,
                            ],
                          )
                        : (state is HomeStateError)
                            ? Center(
                                child: StandardText.headline4(
                                  context,
                                  state.message,
                                  color: DropAndGoColors.black,
                                ),
                              )
                            : const SizedBox.shrink();
              });
            }),
          ),
        ),
      ),
    );
  }
}
