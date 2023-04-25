import 'package:dropandgouser/presentation/analytics/widgets/line_titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
            const FlSpot(0, 35),
            const FlSpot(1, 29),
            const FlSpot(2, 25),
            const FlSpot(3, 37),
            const FlSpot(4, 22),
            const FlSpot(5, 18),
            const FlSpot(6, 40),
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