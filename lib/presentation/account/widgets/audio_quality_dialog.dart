import 'package:dropandgouser/application/account/account_cubit/preference_cubit.dart';
import 'package:dropandgouser/shared/enums/audio_quality.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioQualityDialog extends StatelessWidget {
  const AudioQualityDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StandardText.headline5(context, 'Change audio quality'),
            10.verticalSpace,
            ListView(
              shrinkWrap: true,
              children: AudioQuality.values.map((e) =>  TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<PreferenceCubit>().changeAudioQuality(
                    e.name,
                  );
                },
                child: StandardText.headline6(
                  context,
                  e.name,
                ),
              )).toList(),
            ),

            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //     onSelect();
            //   },
            //   child: StandardText.headline6(
            //     context,
            //     'HD',
            //     color: DropAndGoColors.primary,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
