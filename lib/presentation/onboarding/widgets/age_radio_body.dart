import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/age_radio_item.dart';
import 'package:dropandgouser/shared/enums/age.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeRadioBody extends StatelessWidget {
  const AgeRadioBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeCubit, AgeRange>(
        builder: (context, age) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AgeRadioItem(
                    title: 'onboarding.18'.tr(),
                    onTap: (){
                      context.read<AgeCubit>().onAgeChanged(AgeRange.Age18To29);
                    },
                    isSelected: age == AgeRange.Age18To29,
                  ),
                  AgeRadioItem(
                    title: 'onboarding.30'.tr(),
                    onTap: (){
                      context.read<AgeCubit>().onAgeChanged(AgeRange.Age30To45);
                    },
                    isSelected: age == AgeRange.Age30To45,
                  ),
                ],
              ),
              30.verticalGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AgeRadioItem(
                    title: 'onboarding.46'.tr(),
                    onTap: (){
                      context.read<AgeCubit>().onAgeChanged(AgeRange.Age46To59);
                    },
                    isSelected: age == AgeRange.Age46To59,
                  ),
                  AgeRadioItem(
                    title: 'onboarding.60'.tr(),
                    onTap: (){
                      context.read<AgeCubit>().onAgeChanged(AgeRange.Age60To69);
                    },
                    isSelected: age == AgeRange.Age60To69,
                  ),
                ],
              ),
              30.verticalGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AgeRadioItem(
                    title: 'onboarding.70'.tr(),
                    onTap: (){
                      context.read<AgeCubit>().onAgeChanged(AgeRange.Age70To84);
                    },
                    isSelected: age == AgeRange.Age70To84,
                  ),
                  AgeRadioItem(
                    title: 'onboarding.85'.tr(),
                    onTap: (){
                      context.read<AgeCubit>().onAgeChanged(AgeRange.Age85Plus);
                    },
                    isSelected: age == AgeRange.Age85Plus,
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
}
