import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.search,
  }) : super(key: key);

  final Search search;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              search.imageUrl!,
              width: 73.w,
              height: 70.h,
              fit: BoxFit.cover,
              color: DropAndGoColors.primary.withOpacity(.4),
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
          10.w.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StandardText.headline6(
                context,
                search.title ?? '',
              ),
              6.h.verticalSpace,
              StandardText.button(
                search.artistName ?? "Artist Name",
                fontSize: 10,
                fontWeight: DropAndGoFontWeight.medium,
                color: DropAndGoColors.primary.withOpacity(.4),
                letterSpacing: 0.37.sp,
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: !(search.isFavorite != null && search.isFavorite!)
                    ? SvgPicture.asset(DropAndGoIcons.favoriteFilled)
                    : SvgPicture.asset(DropAndGoIcons.favoriteOutlined),
                onPressed: search.onFavoritePressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}