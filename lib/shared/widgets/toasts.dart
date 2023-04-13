import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

import '../packages/mytoast.dart';

class Toasts {
  late FToast fToast = FToast();

  showToast(
    BuildContext context, {
    required AlertType type,
    required String title,
    required String description,
    VoidCallback? onCloseAlert,
        Color? color,
  }) {
    fToast.init(context);
    Widget toast = Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color ?? (type == AlertType.Error
            ? DropAndGoColors.red
            : DropAndGoColors.white),
      ),
      padding: color==null?null:const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if(color==null)
            Flexible(
            flex: 2,
            child: Icon(
              type == AlertType.Error
                  ? Icons.error
                  : Icons.info_outline,
              color: type == AlertType.Error
                  ? DropAndGoColors.white
                  : DropAndGoColors.black,
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StandardText.subtitle3(
                  context,
                  title,
                  fontWeight: DropAndGoFontWeight.black,
                  color: type == AlertType.Error
                      ? DropAndGoColors.white
                      : DropAndGoColors.black,
                ),
                StandardText.subtitle3(
                  context,
                  description,
                  fontSize: 12,
                  fontWeight: DropAndGoFontWeight.regular,
                  color: type == AlertType.Error
                      ? DropAndGoColors.white
                      : DropAndGoColors.black,
                ),
              ],
            ),
          ),
          Flexible(
            child: IconButton(
              onPressed: fToast.removeCustomToast,
              icon: const Icon(
                Icons.close,
                // color: type == AlertType.Error
                //     ? LocalWalkersColors.alertBoxText
                //     : LocalWalkersColors.infoBoxText,
              ),
            ),
          ),
        ],
      ),
    );
    fToast.removeQueuedCustomToasts();
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(
        seconds: 4,
      ),
    );
  }
}
