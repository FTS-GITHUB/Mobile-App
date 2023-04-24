import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/search/widgets/search_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: StandardText.headline2(
            context,
            "Downloads",
            fontSize: 30,
            color: DropAndGoColors.primary,
          ),
        ),
      ),
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverToBoxAdapter(
            child: HomeRectCategory(),
          ),
          SliverToBoxAdapter(
            child: StandardText.headline5(
              context,
              "Downloads",
              color: DropAndGoColors.primary,
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 10.w,
              ),
              primary: false,
              itemCount: 12,
              itemBuilder: (context, index) {
                return SearchItem(
                  search: Search(
                    title: "ANXIETY",
                    artistName: "Artist Name",
                    imageUrl: DropAndGoImages.addictions,
                    isFavorite: index == 1 ? true : false,
                    onFavoritePressed: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
