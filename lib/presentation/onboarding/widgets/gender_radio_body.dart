import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/shared/enums/gender.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderRadioBody extends StatelessWidget {
  const GenderRadioBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenderCubit, Gender>(
        builder: (context, gender) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: StandardText.headline6(
                  context,
                  'onboarding.male'.tr(),
                  align: TextAlign.start,
                  fontWeight: gender == Gender.Male?DropAndGoFontWeight.semiBold: DropAndGoFontWeight.regular,
                ),
                value: Gender.Male,
                groupValue: gender,
                onChanged: (Gender? value)=>context.read<GenderCubit>().onRadioChanged(value!),
                activeColor: DropAndGoColors.primary,
              ),
              const Divider(
                thickness: 1,
                color: DropAndGoColors.primary,
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: StandardText.headline6(
                  context,
                  'onboarding.female'.tr(),
                  align: TextAlign.start,
                  fontWeight: gender == Gender.Female?DropAndGoFontWeight.semiBold: DropAndGoFontWeight.regular,
                ),
                value: Gender.Female,
                groupValue: gender,
                onChanged: (Gender? value)=>context.read<GenderCubit>().onRadioChanged(value!),
                activeColor: DropAndGoColors.primary,
              ),
              const Divider(
                thickness: 1,
                color: DropAndGoColors.primary,
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: StandardText.headline6(
                  context,
                  'onboarding.other'.tr(),
                  align: TextAlign.start,
                  fontWeight: gender == Gender.Other?DropAndGoFontWeight.semiBold: DropAndGoFontWeight.regular,
                ),
                value: Gender.Other,
                groupValue: gender,
                onChanged: (Gender? value)=>context.read<GenderCubit>().onRadioChanged(value!),
                activeColor: DropAndGoColors.primary,
              ),
            ],
          );
        }
    );
  }
}