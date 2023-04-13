import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/domain/onboarding/user_level_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'level_item.dart';

class LevelRadioBody extends StatelessWidget {
  const LevelRadioBody({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<String>? data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLevelCubit, UserLevelInfo>(
        builder: (context, level) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: data?.length??0,
          itemBuilder: (context, index) {
            return LevelItem(
              isSelected: index == level.index ? true : false,
              title: data?[index]??'',
              onTap: () {
                context.read<UserLevelCubit>().onLevelSelected(
                      value: index,
                      title: data?[index]??'',
                    );
              },
            );
          });
    });
  }
}
