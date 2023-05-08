import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({Key? key,required
  this.searches,
  }) : super(key: key);

  final List<String> searches;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StandardText.headline6(
          context,
          'Previous Search',
        ),
        21.h.verticalSpace,
        const Divider(
          color: DropAndGoColors.primary,
        ),
        ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shrinkWrap: true,
          itemCount: searches.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  StandardText.headline6(
                    context,
                    searches[index],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      DropAndGoIcons.backSpaceOutlined,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
