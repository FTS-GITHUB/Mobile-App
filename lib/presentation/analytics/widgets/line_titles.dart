import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
            case (7):
              labelX='Sun';
              break;
            case (1):
              labelX='Mon';
              break;
            case (2):
              labelX='Tue';
              break;
            case (3):
              labelX='Wed';
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
            'Day ${titleMeta.formattedValue}',
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