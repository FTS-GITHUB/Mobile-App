import 'dart:math';

import 'package:dropandgouser/application/complete_profile/cubit/profile_file_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountAppBar extends StatelessWidget {
  const AccountAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          if(title.toLowerCase().contains('personal')){
            context.read<ProfileFileCubit>().dispose();
          }
          getIt<NavigationService>().navigateBack(context: context);
        },
        child: Transform.rotate(
          angle: pi,
          child: Transform.scale(
            scale: .4,
            child: SvgPicture.asset(
              DropAndGoIcons.arrowForward,
              color: DropAndGoColors.primary,
            ),
          ),
        ),
      ),
      // leadingWidth: 50,
      titleSpacing: -5,
      title: StandardText.headline4(
        context,
        title,
        color: DropAndGoColors.primary,
        fontSize: 20,
      ),
    );
  }
}
