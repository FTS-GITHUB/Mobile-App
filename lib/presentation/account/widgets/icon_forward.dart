import 'dart:math';

import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconForward extends StatelessWidget {
  const IconForward({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: SvgPicture.asset(
        DropAndGoIcons.arrowLeft,
      ),
    );
  }
}
