import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.drawer,
            ),
            onPressed: () {},
          ),
          title: StandardText.headline5(
            context,
            "Home",
            color: DropAndGoColors.black,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                DropAndGoIcons.search,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                DropAndGoIcons.notification,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: context.width - 72,
          height: context.height * 0.22,
          decoration: BoxDecoration(
            color: DropAndGoColors.primary,
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(
                DropAndGoImages.defaultCategory,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                DropAndGoColors.primary,
                BlendMode.softLight,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: StandardText.headline4(
            context,
            "SELF IMPROVEMENT",
            color: DropAndGoColors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
