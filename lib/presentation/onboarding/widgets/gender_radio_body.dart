import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/domain/onboarding/gender.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderRadioBody extends StatelessWidget {
  const GenderRadioBody({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<String>? data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenderCubit, Gender>(builder: (context, gender) {
      return data == null || data!.isEmpty
          ? StandardText.headline6(
              context,
              'No gender added',
            )
          : GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data?.length ?? 0,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5.6,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: StandardText.headline6(
                        context,
                        data?[index] ?? 'N/A',
                        // 'onboarding.male'.tr(),
                        align: TextAlign.start,
                        fontWeight: gender.index == index
                            ? DropAndGoFontWeight.semiBold
                            : DropAndGoFontWeight.regular,
                      ),
                      value: data?[index],
                      groupValue: gender.value,
                      onChanged: (value) {
                        context.read<GenderCubit>().onRadioChanged(Gender(
                              index: index,
                              value: data?[index] ?? '',
                            ));
                      },
                      activeColor: DropAndGoColors.primary,
                    ),
                Visibility(
                  visible: index!=(data?.length??0-1),
                  child: const Divider(
                        thickness: 1,
                        color: DropAndGoColors.primary,
                      ),
                ),
                  ],
                );
              });
    });
  }
}
