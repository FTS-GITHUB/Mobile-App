import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClearCacheDialog extends StatelessWidget {
  const ClearCacheDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StandardText.headline5(context, 'Do you want to clear cache?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  // onConfirm();
                },
                child: StandardText.headline6(
                  context,
                  'Yes',
                  color: DropAndGoColors.red,
                ),
              ),
              6.horizontalSpace,
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: StandardText.headline6(
                  context,
                  'No',
                  color: DropAndGoColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}