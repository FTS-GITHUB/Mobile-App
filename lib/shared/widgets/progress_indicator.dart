import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double maxValue;
  final double value;
  final Color barColor;

  const ProgressBar({
    Key? key,
    required this.maxValue,
    required this.value,
    this.barColor = DropAndGoColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var width = boxConstraints.maxWidth - 40;
        var percent = (value / maxValue) * width;
        return Stack(
          children: [
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                color: DropAndGoColors.progressBarBg,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              width: percent,
              height: 10,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        );
      },
    );
  }
}
