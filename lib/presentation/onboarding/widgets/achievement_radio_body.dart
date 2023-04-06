import 'package:dropandgouser/application/onboarding/cubit/achievement_cubit.dart';
import 'package:dropandgouser/domain/onboarding/achievement_info.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/achievement_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AchievementRadioBody extends StatelessWidget {
  const AchievementRadioBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AchievementCubit, AchievementInfo>(
        builder: (context, achievementIndex) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: 7,
          itemBuilder: (context, index) {
            return AchievementItem(
              isSelected: index == achievementIndex.index ? true : false,
              // TODO: after fetching from firestore,
              // do achievements[index].title
              title: 'Lorem ipsum is a placeholder',
              onTap: () {
                context.read<AchievementCubit>().onAchievementSelected(
                      value: index,
                      title: 'Lorem ipsum is a placeholder',
                    );
              },
            );
          });
    });
  }
}
