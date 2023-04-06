import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/domain/onboarding/user_level_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'level_item.dart';

class LevelRadioBody extends StatelessWidget {
  const LevelRadioBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLevelCubit, UserLevelInfo>(
        builder: (context, level) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return LevelItem(
              isSelected: index == level.index ? true : false,
              // TODO: after fetching from firestore,
              // do achievements[index].title
              title:
                  index ==0?
              'onboarding.level1'.tr():
              index ==1?'onboarding.level2'.tr():
                  index ==2?'onboarding.level3'.tr():
                      index ==3? 'onboarding.level4'.tr():
                          index ==4?'onboarding.level5'.tr():
                          'onboarding.level6'.tr(),
              onTap: () {
                context.read<UserLevelCubit>().onLevelSelected(
                      value: index,
                      title: 'Lorem ipsum is a placeholder',
                    );
              },
            );
          });
    });
  }
}
