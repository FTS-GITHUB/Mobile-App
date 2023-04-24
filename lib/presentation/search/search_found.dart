import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/presentation/search/widgets/search_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFound extends StatelessWidget {
  const SearchFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 10.w,
        ),
        primary: false,
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder: (context, index) {
          return SearchItem(
            search: Search(
              title: "ANXIETY",
              artistName: "Artist Name",
              imageUrl: DropAndGoImages.defaultCategory,
              isFavorite: index == 1 ? true : false,
              onFavoritePressed: () {},
            ),
          );
        });
  }
}
