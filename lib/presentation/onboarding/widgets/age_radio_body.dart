import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/domain/onboarding/age.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/age_radio_item.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgeRadioBody extends StatelessWidget {
  const AgeRadioBody({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<String>? data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeCubit, Age>(builder: (context, age) {
      return data == null || data!.isEmpty
          ? StandardText.headline6(
              context,
              'No age added',
            )
          : GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data?.length ?? 0,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.8,
                crossAxisSpacing: 30.w,
                mainAxisSpacing: 30.h,
              ),
              itemBuilder: (context, index) {
                return AgeRadioItem(
                  title: data?[index] ?? '',
                  // title: 'onboarding.18'.tr(),
                  onTap: () {
                    context.read<AgeCubit>().onAgeChanged(
                          Age(
                            index: index,
                            value: data?[index] ?? '',
                          ),
                        );
                  },
                  isSelected: age.index == index,
                );
              });
    });
  }
}
