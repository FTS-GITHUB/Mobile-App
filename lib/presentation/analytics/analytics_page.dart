import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/analytics/widgets/streak_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      Flexible(child: Container(
                        margin: EdgeInsets.only(top: 25.h, left: 12.w,),
                          child: LineChartWidget())),
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

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  final gradientColors = const LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(255, 255, 255, .3),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 40,

          titlesData: LineTitles.getTitleData(context),
          gridData: FlGridData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 35),
                FlSpot(1, 29),
                FlSpot(2, 25),
                FlSpot(3, 37),
                FlSpot(4, 22),
                FlSpot(5, 18),
                FlSpot(6, 40),
              ],
              isCurved: true,
              gradient: gradientColors,
              barWidth: 0,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: gradientColors,
              ),
            ),
          ],
        ),
      );
}

class LineTitles {
  static getTitleData(BuildContext context) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          axisNameSize: 30,
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 26,
            interval: 1,
            getTitlesWidget: (value, titleMeta) {
              String labelX ='';
              switch(value.toInt()){
                case (0):
                  labelX='Sun';
                  break;
                case (1):
                  labelX='Mon';
                  break;
                case (2):
                  labelX='Tue';
                  break;
                case (3):
                  labelX='Tue';
                  break;
                case (4):
                  labelX='Thu';
                  break;
                case (5):
                  labelX='Fri';
                  break;
                case (6):
                  labelX='Sat';
                  break;
              }
              return StandardText.headline6(
                context,
                labelX,
                color: DropAndGoColors.white,
                fontSize: 12,
              );
            },
          ),
        ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            getTitlesWidget: (value, _) {
              return StandardText.headline6(
                context,
                "${value.toInt().toString()}m",
                color: DropAndGoColors.white,
                fontSize: 12,
              );
            },
          ),
        ),
      );
}
