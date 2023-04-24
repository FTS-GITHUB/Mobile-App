import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              DropAndGoImages.analyticsBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: StandardText.headline2(context, "Analytics"),
        ),
      ),
    );
  }
}
