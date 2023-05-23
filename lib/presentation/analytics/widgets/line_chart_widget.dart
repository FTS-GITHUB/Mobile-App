import 'package:dropandgouser/application/analytics/analytics_bloc/analytics_bloc.dart';
import 'package:dropandgouser/presentation/analytics/widgets/line_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) =>
      BlocBuilder<AnalyticsBloc, AnalyticsState>(builder: (context, state) {
        return (state is AnalyticsStateLoading)
            ? const SizedBox.shrink()
            : (state is AnalyticsStateLoaded)
                ? LineChart(
                    LineChartData(
                      minX: 1,
                      maxX: state.chartData.length<7?state.chartData.length.toDouble():7,
                      minY: 0,
                      maxY: state.maxMinutes,
                      titlesData: LineTitles.getTitleData(context),
                      gridData: FlGridData(
                        show: false,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getListFlSpot(state: state),
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
                  )
                : const SizedBox.shrink();
      });

  List<FlSpot>? getListFlSpot({required AnalyticsState state}) {
    if (state is AnalyticsStateLoaded) {
      switch (state.chartData.length) {
        case 0:
          return [];
        case 1:
          return [
            FlSpot(state.chartData[0].year.weekday.toDouble(),
                state.chartData[0].y1),
          ];
        case 2:
          return [
            FlSpot(state.chartData[0].year.weekday.toDouble(),
                state.chartData[0].y1),
            FlSpot(state.chartData[0].year.weekday + 1.toDouble(),
                state.chartData[1].y1),
          ];
        case 3:
          return [
            FlSpot(state.chartData[0].year.weekday.toDouble(),
                state.chartData[0].y1),
            FlSpot(state.chartData[0].year.weekday + 1.toDouble(),
                state.chartData[1].y1),
            FlSpot(state.chartData[0].year.weekday + 2.toDouble(),
                state.chartData[2].y1),
          ];
        case 4:
          return [
            FlSpot(state.chartData[0].year.weekday.toDouble(),
                state.chartData[0].y1),
            FlSpot(state.chartData[0].year.weekday + 1.toDouble(),
                state.chartData[1].y1),
            FlSpot(state.chartData[0].year.weekday + 2.toDouble(),
                state.chartData[2].y1),
            FlSpot(state.chartData[0].year.weekday + 3.toDouble(),
                state.chartData[3].y1),
          ];
        case 5:
          return [
            FlSpot(state.chartData[0].year.weekday.toDouble(),
                state.chartData[0].y1),
            FlSpot(state.chartData[0].year.weekday + 1.toDouble(),
                state.chartData[1].y1),
            FlSpot(state.chartData[0].year.weekday + 2.toDouble(),
                state.chartData[2].y1),
            FlSpot(state.chartData[0].year.weekday + 3.toDouble(),
                state.chartData[3].y1),
            FlSpot(state.chartData[0].year.weekday + 4.toDouble(),
                state.chartData[4].y1),
          ];
        case 6:
          return [
            FlSpot(state.chartData[0].year.weekday.toDouble(),
                state.chartData[0].y1),
            FlSpot(state.chartData[0].year.weekday + 1.toDouble(),
                state.chartData[1].y1),
            FlSpot(state.chartData[0].year.weekday + 2.toDouble(),
                state.chartData[2].y1),
            FlSpot(state.chartData[0].year.weekday + 3.toDouble(),
                state.chartData[3].y1),
            FlSpot(state.chartData[0].year.weekday + 4.toDouble(),
                state.chartData[4].y1),
            FlSpot(state.chartData[0].year.weekday + 5.toDouble(),
                state.chartData[5].y1),
          ];
        case 7:
          return [
            FlSpot(state.chartData[0].year.weekday.toDouble(),
                state.chartData[0].y1),
            FlSpot(state.chartData[0].year.weekday + 1.toDouble(),
                state.chartData[1].y1),
            FlSpot(state.chartData[0].year.weekday + 2.toDouble(),
                state.chartData[2].y1),
            FlSpot(state.chartData[0].year.weekday + 3.toDouble(),
                state.chartData[3].y1),
            FlSpot(state.chartData[0].year.weekday + 4.toDouble(),
                state.chartData[4].y1),
            FlSpot(state.chartData[0].year.weekday + 5.toDouble(),
                state.chartData[5].y1),
            FlSpot(state.chartData[0].year.weekday + 6.toDouble(),
                state.chartData[6].y1),
          ];
      }
    }
  }
}
