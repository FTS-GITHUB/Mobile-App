import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/flutter_switch.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCupertinoSwitch extends StatelessWidget {
  const AppCupertinoSwitch({
    Key? key,
    required this.title,
    required this.switchValue,
    required this.onChangedSwitch,
  }) : super(key: key);

  final bool switchValue;
  final ValueChanged<bool> onChangedSwitch;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StandardText.headline6(
          context,
          title.toUpperCase(),
        ),
        Transform.scale(
          scale: .5,
          child: FlutterSwitch(
            activeColor: DropAndGoColors.blue,
            inactiveColor: DropAndGoColors.blue,
            value: switchValue,
            onToggle: onChangedSwitch,
          ),
        ),
        // Transform.scale(
        //   scale: .6,
        //   child: CupertinoSwitch(
        //     trackColor: DropAndGoColors.blue,
        //     activeColor: DropAndGoColors.blue,
        //     value: switchValue,
        //     onChanged: onChangedSwitch,
        //   ),
        // ),
      ],
    );
  }
}
