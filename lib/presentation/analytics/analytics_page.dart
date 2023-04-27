import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/analytics/widgets/line_chart_widget.dart';
import 'package:dropandgouser/presentation/analytics/widgets/streak_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _SplineAreaData {
  _SplineAreaData(
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
  List<_SplineAreaData>? chartData = <_SplineAreaData>[
    _SplineAreaData(
      DateTime(2010, 04, 06),
      0,
    ),
    _SplineAreaData(
      DateTime(2010, 04, 07),
      35.5,
    ),
    _SplineAreaData(
      DateTime(2010, 04, 08),
      20,
    ),
    _SplineAreaData(
      DateTime(2010, 04, 09),
      32,
    ),
    _SplineAreaData(
      DateTime(2010, 04, 10),
      25,
    ),
    _SplineAreaData(
      DateTime(2010, 04, 11),
      37,
    ),
    _SplineAreaData(
      DateTime(2010, 04, 06),
      30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StandardText.headline4(
                            context,
                            '10h 50m',
                            fontSize: 30.sp,
                            color: DropAndGoColors.white,
                          ),
                          AppButton(
                            color: DropAndGoColors.white,
                            enableColor: DropAndGoColors.primary,
                            textColor: DropAndGoColors.primary,
                            textSize: 12,
                            width: context.width * .25,
                            height: 35,
                            radius: 4,
                            onPressed: () {
                              print("Hoefler Text");
                            },
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
                ),
                13.verticalSpace,
                GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                  ),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 26.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 2.1.h,
                  ),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? const StreakItem(
                            title: 'Current Streak',
                            data: "12d",
                          )
                        : index == 1
                            ? const StreakItem(
                                title: 'Longest Streak',
                                data: "16d",
                              )
                            : index == 3
                                ? const StreakItem(
                                    title: 'Sessions listened',
                                    data: "45",
                                  )
                                : const StreakItem(
                                    title: 'Packs listened',
                                    data: "15",
                                  );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
