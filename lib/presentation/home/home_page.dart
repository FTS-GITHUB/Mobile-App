import 'package:cron/cron.dart';
import 'package:dropandgouser/application/home/home_bloc/home_bloc.dart';
import 'package:dropandgouser/application/likes_bloc/likes_cubit.dart';
import 'package:dropandgouser/application/likes_bloc/likes_state.dart';
import 'package:dropandgouser/application/session/session_bloc/session_bloc.dart';
import 'package:dropandgouser/application/session/session_cubit/session_completed_cubit.dart';
import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/main.dart';
import 'package:dropandgouser/presentation/home/widgets/category_view_more_header.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/home/widgets/home_square_category.dart';
import 'package:dropandgouser/presentation/session_complete/session_complete_page.dart';
import 'package:dropandgouser/shared/animations/slide_animation.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late UserService? userService;
  Cron cron = Cron();

  @override
  void initState() {
    userService = getIt<UserService>();
    uploadSession();
    refreshPage();
    runEveryMinute();
    super.initState();
  }

  runEveryMinute() async {
    cron.schedule(Schedule.parse('* * * * *'), () async {
      bool isSessionCompleted = context.read<SessionCompletedCubit>().state;
      // TODO: change duration to user level duration
      if (sessionInMinutes > 10 && !isSessionCompleted) {
        context.read<SessionCompletedCubit>().initialize(true);
        showDialog(
          context: context,
          builder: (ctx) => const SessionCompletePage(),
        );
      }
    });
  }

  refreshPage() {
    context.read<UserBloc>().add(FetchUser());
    context.read<HomeBloc>().add(FetchCategories());
  }

  uploadSession() {
    if (userService?.userData?.id != null) {
      context.read<SessionBloc>().add(
            GetAllSessions(
              userId: userService!.userData!.id!,
              isSessionCompleted: context.read<SessionCompletedCubit>().state,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeStateLoaded) {
              bool isRemindAtBedtime =
                  getIt<UserService>().userSetting?.isRemindBedtime ?? false;
              bool isTimeRangeValid = isValidTimeRange(
                const TimeOfDay(hour: 22, minute: 30),
                const TimeOfDay(hour: 23, minute: 0),
              );
              if (isRemindAtBedtime && isTimeRangeValid) {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        content: Column(
                          children: [
                            StandardText.headline5(
                              context,
                              'Reminder for bedtime',
                            ),
                          ],
                        ),
                      );
                    });
              }
            }
          },
        ),
        BlocListener<SessionBloc, SessionState>(
          listener: (context, state) {
            if (state is SessionStateUploaded) {
              deletePreviousSession();
              context.read<SessionCompletedCubit>().initialize(false);
            }
          },
        ),
      ],
      child: Scaffold(
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
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                return (state is HomeStateLoaded)
                    ? IconButton(
                        onPressed: () {
                          getIt<NavigationService>().pushNamed(
                            context: context,
                            uri: NavigationService.searchRouteUri,
                            data: state.allCategories,
                          );
                        },
                        icon: SvgPicture.asset(
                          DropAndGoIcons.search,
                        ),
                      )
                    : const SizedBox.shrink();
              }),
              // IconButton(
              //   onPressed: () {},
              //   icon: SvgPicture.asset(
              //     DropAndGoIcons.notification,
              //   ),
              // ),
            ],
          ),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: DropAndGoColors.primary,
          backgroundColor: DropAndGoColors.white,
          onRefresh: () async => refreshPage(),
          child: SingleChildScrollView(
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
                    getIt<UserService>().userData = state.userData;
                    getIt<UserService>().userSetting = state.userSetting;
                    SharedPreferenceHelper.isBiometricEnabled =
                        state.userSetting.isBiometric;
                    debugPrint("User Name: ${state.userData.fullName}");
                    debugPrint(
                        "Liked Categories: ${state.userData.likedCategories}");
                  }
                },
                child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                  return BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                    final user = getIt<UserService>();
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
                                                  state.randomCategory.name !=
                                                      null,
                                              child: BlocBuilder<LikesCubit,
                                                      LikesState>(
                                                  builder:
                                                      (context, likeState) {
                                                return (likeState
                                                        is LikesStateLoading)
                                                    ? const SizedBox.shrink()
                                                    : (likeState
                                                            is LikesStateLoaded)
                                                        ? HomeRectCategory(
                                                            categoryName: state
                                                                .randomCategory
                                                                .name,
                                                            imageUrl: state
                                                                .randomCategory
                                                                .imageUrl,
                                                            isLiked: likeState
                                                                            .userData
                                                                            .likedCategories !=
                                                                        null &&
                                                                    likeState
                                                                        .userData
                                                                        .likedCategories!
                                                                        .contains(state
                                                                            .randomCategory
                                                                            .id!)
                                                                ? true
                                                                : false,
                                                            onLike: () {
                                                              if (state
                                                                      .randomCategory
                                                                      .id !=
                                                                  null) {
                                                                context
                                                                    .read<
                                                                        LikesCubit>()
                                                                    .likeCategory(
                                                                      categoryId: state
                                                                          .randomCategory
                                                                          .id!,
                                                                    );
                                                              }
                                                            },
                                                            onShare: () {},
                                                            onTap: () {
                                                              getIt<NavigationService>()
                                                                  .navigateToNamed(
                                                                context:
                                                                    context,
                                                                uri: NavigationService
                                                                    .categoryDetailRouteUri,
                                                                data: state
                                                                    .randomCategory
                                                                    .id,
                                                              );
                                                            },
                                                          )
                                                        : HomeRectCategory(
                                                            categoryName: state
                                                                .randomCategory
                                                                .name,
                                                            imageUrl: state
                                                                .randomCategory
                                                                .imageUrl,
                                                            isLiked: user.userData!
                                                                            .likedCategories !=
                                                                        null &&
                                                                    user.userData!
                                                                        .likedCategories!
                                                                        .contains(state
                                                                            .randomCategory
                                                                            .id!)
                                                                ? true
                                                                : false,
                                                            onLike: () {
                                                              // if (state.randomCategory.id !=
                                                              //     null) {
                                                              //   context
                                                              //       .read<LikesCubit>()
                                                              //       .likeCategory(
                                                              //     categoryId: state
                                                              //         .randomCategory.id!,
                                                              //   );
                                                              // }
                                                            },
                                                            onShare: () {},
                                                            onTap: () {
                                                              getIt<NavigationService>()
                                                                  .navigateToNamed(
                                                                context:
                                                                    context,
                                                                uri: NavigationService
                                                                    .categoryDetailRouteUri,
                                                                data: state
                                                                    .randomCategory
                                                                    .id,
                                                              );
                                                            },
                                                          );
                                              }),
                                            )
                                          : const SizedBox.shrink(),
                                  35.h.verticalSpace,
                                  SlideInAnimation(
                                    child: CategoryViewMoreHeader(
                                      onViewMore: () {
                                        getIt<NavigationService>()
                                            .navigateToNamed(
                                          context: context,
                                          uri: NavigationService
                                              .categoriesRouteUri,
                                          data: state.allCategories,
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
                                            data: category.id,
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
                                        getIt<NavigationService>()
                                            .navigateToNamed(
                                          context: context,
                                          uri: NavigationService
                                              .categoriesRouteUri,
                                          data: state.recommendedCategories,
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
                                            data: category.id,
                                          );
                                        },
                                      );
                                    },
                                    itemCount:
                                        state.recommendedCategories.length > 2
                                            ? 2
                                            : state
                                                .recommendedCategories.length,
                                  ),
                                  20.h.verticalSpace,
                                  SlideInAnimation(
                                    child: CategoryViewMoreHeader(
                                      categoryName: 'For Better Sleep',
                                      onViewMore: () {
                                        getIt<NavigationService>()
                                            .navigateToNamed(
                                          context: context,
                                          uri: NavigationService
                                              .categoriesRouteUri,
                                          data: state.forBetterSleepCategories,
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
                                            data: category.id,
                                          );
                                        },
                                      );
                                    },
                                    itemCount: state.forBetterSleepCategories
                                                .length >
                                            4
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
        ),
      ),
    );
  }
}
