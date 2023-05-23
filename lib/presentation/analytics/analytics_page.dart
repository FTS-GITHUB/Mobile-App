import 'package:dropandgouser/application/analytics/analytics_bloc/analytics_bloc.dart';
import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/analytics/widgets/line_chart_widget.dart';
import 'package:dropandgouser/presentation/analytics/widgets/streak_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplineAreaData {
  SplineAreaData(
    this.year,
    this.y1,
  );

  final DateTime year;
  final double y1;
}

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  void initState() {
    context.read<AnalyticsBloc>().add(
          FetchAnalytics(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userService = getIt<UserService>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.arrowLeft,
              color: DropAndGoColors.white,
            ),
            onPressed: () {
              context.read<MainNavBarCubit>().changeBottomNavBar(0);
              getIt<NavigationService>().navigateBack(context: context);
            },
          ),
          backgroundColor: DropAndGoColors.transparent,
          title: StandardText.headline4(
            context,
            'Analytics',
            fontSize: 30.sp,
          ),
        ),
      ),
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              DropAndGoImages.analyticsBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
                builder: (context, state) {
              return Column(
                children: [
                  (state is AnalyticsStateLoading)
                      ? const DropAndGoButtonLoading()
                      : (state is AnalyticsStateLoaded)
                          ? state.chartData.isEmpty
                              ? Center(
                                  child: StandardText.headline4(
                                    context,
                                    'Not enough data',
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 36.w,
                                    vertical: 12.h,
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  height: context.height * .4,
                                  decoration: BoxDecoration(
                                    color: DropAndGoColors.primary,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          StandardText.headline4(
                                            context,
                                            getTotalTime(state.totalTimeInMinutes??0),
                                            fontSize: 30.sp,
                                            color: DropAndGoColors.white,
                                          ),
                                          AppButton(
                                            color: DropAndGoColors.white,
                                            enableColor:
                                                DropAndGoColors.primary,
                                            textColor: DropAndGoColors.primary,
                                            textSize: 12,
                                            width: context.width * .25,
                                            height: 35,
                                            radius: 4,
                                            onPressed: () {},
                                            text: 'This Week',
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: 25.h,
                                            left: 12.w,
                                          ),
                                          child: const LineChartWidget(),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                          : (state is AnalyticsStateError)
                              ? Center(
                                  child: StandardText.headline4(
                                    context,
                                    state.message,
                                  ),
                                )
                              : const SizedBox.shrink(),
                  13.verticalSpace,
                  GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 36.w,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 3,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 26.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 2.1.h,
                    ),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? StreakItem(
                              title: 'Current Streak',
                              data:
                                  "${userService.userData?.currentStreak ?? 0}d",
                            )
                          : index == 1
                              ? StreakItem(
                                  title: 'Longest Streak',
                                  data:
                                      "${userService.userData?.longestStreak ?? 0}d",
                                )
                              : StreakItem(
                                  title: 'Sessions listened',
                                  data:
                                      "${userService.userData?.sessionsListened ?? 0}",
                                );
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }


  String getTotalTime(double time){
    int timeToRound = time.round();
    if(timeToRound < 60){
      return '${timeToRound}m';
    }else if (timeToRound>=60 && timeToRound <120){
      return '1h ${timeToRound-60}m';
    }else if (timeToRound>=120 && timeToRound <180){
      return '2h ${timeToRound-120}m';
    }else if (timeToRound>=180 && timeToRound <240){
      return '3h ${timeToRound-180}m';
    }else if (timeToRound>=240 && timeToRound <300){
      return '4h ${timeToRound-240}m';
    }else if (timeToRound>=300 && timeToRound <360){
      return '5h ${timeToRound-300}m';
    }else if (timeToRound>=360 && timeToRound <420){
      return '6h ${timeToRound-360}m';
    }else if (timeToRound>=420 && timeToRound <480){
      return '7h ${timeToRound-420}m';
    }else if (timeToRound>=480 && timeToRound <540){
      return '8h ${timeToRound-480}m';
    }else if (timeToRound>=540 && timeToRound <600){
      return '9h ${timeToRound-540}m';
    }else if (timeToRound>=600 && timeToRound <660){
      return '10h ${timeToRound-600}m';
    }else if (timeToRound>=660 && timeToRound <720){
      return '11h ${timeToRound-660}m';
    }else if (timeToRound>=720 && timeToRound <780){
      return '12h ${timeToRound-720}m';
    }else{
      return '${time}m';
    }
  }
}
