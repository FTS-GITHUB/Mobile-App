import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryViewMoreHeader extends StatelessWidget {
  const CategoryViewMoreHeader({
    Key? key,
    this.categoryName,
    this.onViewMore,
  }) : super(key: key);

  final String? categoryName;
  final VoidCallback? onViewMore;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onViewMore,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StandardText.headline4(
            context,
            categoryName??'Explore by Categories',
            fontSize: 20,
          ),
          SvgPicture.asset(
            DropAndGoIcons.arrowForward,
            color: DropAndGoColors.primary,
          ),
        ],
      ),
    );
  }
}