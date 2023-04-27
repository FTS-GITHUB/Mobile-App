import 'dart:math';

import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: false,
          leading: Transform.rotate(
            angle: pi,
            child: Transform.scale(
              scale: .4,
              child: SvgPicture.asset(
                DropAndGoIcons.arrowForward,
                color: DropAndGoColors.primary,
              ),
            ),
          ),
          // leadingWidth: 50,
          titleSpacing: -5,
          title: StandardText.headline4(
            context,
            'Personal info',
            color: DropAndGoColors.primary,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
