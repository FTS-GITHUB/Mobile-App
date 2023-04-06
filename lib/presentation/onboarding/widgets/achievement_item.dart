import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  const AchievementItem({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: DropAndGoColors.primary,
        contentPadding:
        const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outlined,
            color: DropAndGoColors.white,
          ),
        ),
        minLeadingWidth: 10,
        title: StandardText.headline6(
          context,
          title,
          color: DropAndGoColors.white,
        ),
      ),
    );
  }
}