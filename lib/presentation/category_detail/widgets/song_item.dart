import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SongItem extends StatelessWidget {
  const SongItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              DropAndGoImages.defaultCategory,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
              color: DropAndGoColors.primary.withOpacity(.4),
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
          10.w.horizontalSpace,
          Expanded(
            child: StandardText.headline6(
              context,
              'Through the veins Through the' ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: SvgPicture.asset(
                DropAndGoIcons.playCircle,
                width: 30,
                height: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
