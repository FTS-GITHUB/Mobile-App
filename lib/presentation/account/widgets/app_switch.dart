import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/flutter_switch.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    Key? key,
    required this.title,
    required this.switchValue,
    required this.onChangedSwitch,
    this.switchColor,
    this.isUpperCase=true,
  }) : super(key: key);

  final bool switchValue;
  final ValueChanged<bool> onChangedSwitch;
  final String title;
  final Color? switchColor;
  final bool isUpperCase;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: StandardText.headline6(
            context,
            isUpperCase?title.toUpperCase():title,
          ),
        ),
        Transform.scale(
          scale: .5,
          child: FlutterSwitch(
            activeColor: switchColor?? DropAndGoColors.blue,
            inactiveColor: switchColor??DropAndGoColors.blue,
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
