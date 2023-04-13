import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/font_family.dart';
import 'package:dropandgouser/shared/helpers/typography/font_weights.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    this.isUpperCaseText = true,
    this.icon,
    this.onPressed,
    Key? key,
    this.height,
    this.width = 234,
    this.radius = 8,
    this.color,
    this.borderColor,
    this.textColor = Colors.white,
    this.textSize = 15.0,
    this.textAlign = TextAlign.center,
    this.fontWeight = DropAndGoFontWeight.regular,
    this.leftHalfRadius = false,
    this.rightHalfRadius = false,
    this.letterSpacing = 0,
    this.isLoading = false,
    this.loaderColor,
    this.enableColor,
    this.isPrefixIcon = true,
    this.fontFamily = DropAndGoFontFamily.poppins,
  }) : super(key: key);

  /// text does not show if child is given.
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? loaderColor;
  final Color? textColor;
  final Color? enableColor;
  final double textSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool isUpperCaseText;
  final double? height;
  final double width;
  final double radius;
  final Color? borderColor;
  final bool leftHalfRadius;
  final bool rightHalfRadius;
  final double? letterSpacing;
  final bool isLoading;
  final bool isPrefixIcon;
  final String fontFamily;
  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    return Container(
      height: height??64.h,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(leftHalfRadius ? 0 : radius),
          right: Radius.circular(rightHalfRadius ? 0 : radius),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: DropAndGoColors.primary,
          backgroundColor: color ?? DropAndGoColors.black,
          disabledForegroundColor: DropAndGoColors.black,
          // make the button as small as possible
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 0,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(leftHalfRadius ? 0 : radius),
              bottomLeft: Radius.circular(leftHalfRadius ? 0 : radius),
              topRight: Radius.circular(rightHalfRadius ? 0 : radius),
              bottomRight: Radius.circular(rightHalfRadius ? 0 : radius),
            ),
            side: BorderSide(
              color: borderColor ?? DropAndGoColors.black,
            ),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    loaderColor ?? Colors.white,
                  ),
                  backgroundColor: loaderColor ?? DropAndGoColors.black,
                ),
              )
            : icon != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (isPrefixIcon) icon!,
                        StandardText.button(
                          text,
                          color: isEnabled
                              ? (textColor ?? DropAndGoColors.white)
                              : DropAndGoColors.white,
                          align: textAlign,
                          fontSize: textSize,
                          fontWeight: fontWeight,
                          letterSpacing: letterSpacing,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: fontFamily,
                        ),
                        6.horizontalGap,
                        if (!isPrefixIcon) icon!,
                      ],
                    ),
                  )
                : StandardText.button(
                    isUpperCaseText ? text : text,
                    color: (isEnabled
                        ? enableColor ?? DropAndGoColors.white
                        : textColor ?? DropAndGoColors.white),
                    align: textAlign,
                    fontSize: textSize,
                    fontWeight: fontWeight,
                    letterSpacing: letterSpacing,
                    fontFamily: fontFamily,
                  ),
      ),
    );
  }
}
