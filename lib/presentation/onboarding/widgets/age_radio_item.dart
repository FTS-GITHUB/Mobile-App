import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class AgeRadioItem extends StatelessWidget {
  const AgeRadioItem({
    Key? key,
    this.isSelected = false,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? DropAndGoColors.primary : DropAndGoColors.white,
          border: Border.all(
            color: DropAndGoColors.primary,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: StandardText.headline5(
          context,
          title,
          color: isSelected? DropAndGoColors.white: DropAndGoColors.primary,
        ),
      ),
    );
  }
}
