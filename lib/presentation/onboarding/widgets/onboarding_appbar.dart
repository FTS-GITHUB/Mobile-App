import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingAppbar extends StatelessWidget {
  const OnboardingAppbar({
    Key? key,
    required this.barValue,
    required this.onBack,
  }) : super(key: key);

  final double barValue;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(DropAndGoIcons.arrowBack),
        onPressed: onBack,
      ),
      title: ProgressBar(
        maxValue: 1,
        value: barValue,
      ),
    );
  }
}