// ignore_for_file: use_build_context_synchronously, file_names

import 'package:dropandgouser/application/complete_profile/cubit/dob_date_cubit.dart';
import 'package:dropandgouser/shared/extensions/datetime_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropAndGoDatePicker {
  static Future<void> showMaterialDatePicker(
    BuildContext context, {
    required DateTime initialDate,
    required TextEditingController dobTextEditingController,
  }) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(
          1900,
          DateTime.now().month,
          DateTime.now().day,
        ),
        lastDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: DropAndGoColors.primary,
                onPrimary: DropAndGoColors.white,
              ),
            ),
            child: child!,
          );
        });
      context
          .read<DobDateCubit>()
          .onDateSelected(pickedDate);
      if(pickedDate!=null){
        dobTextEditingController.text = pickedDate.toDateMonthYear();
      }
  }

  static showCupertinoDatePicker(
    BuildContext context, {
    required DateTime initialDate,
    required TextEditingController dobTextEditingController,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (pickedDate) {
              context
                  .read<DobDateCubit>()
                  .onDateSelected(pickedDate);
            },
            initialDateTime: initialDate,
            minimumYear: 1900,
            maximumYear: DateTime.now().year,
          ),
        );
      },
    );
  }
}

// onTap: () async {
// final ThemeData theme = Theme.of(context);
// switch (theme.platform) {
// case TargetPlatform.android:
// case TargetPlatform.fuchsia:
// case TargetPlatform.linux:
// case TargetPlatform.windows:
// return GioscoreDatePicker.showMaterialDatePicker(
// context,
// initialDate: context.read<CalenderDateCubit>().state,
// );
// case TargetPlatform.iOS:
// case TargetPlatform.macOS:
// return GioscoreDatePicker.showCupertinoDatePicker(
// context,
// initialDate: context.read<CalenderDateCubit>().state,
// );
// }
// },
