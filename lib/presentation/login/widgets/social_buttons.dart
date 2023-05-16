import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: SvgPicture.asset(
            DropAndGoIcons.google,
          ),
        ),
        // const Spacer(),
        // Flexible(
        //   flex: 5,
        //   child: SvgPicture.asset(
        //     DropAndGoIcons.apple,
        //   ),
        // ),
        const Spacer(),
        Flexible(
          flex: 5,
          child: SvgPicture.asset(
            DropAndGoIcons.facebook,
          ),
        ),
      ],
    );
  }
}
