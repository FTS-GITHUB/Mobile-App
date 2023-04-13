import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/typography/text_styles.dart';

class StandardTextField extends StatelessWidget {
  const StandardTextField({
    Key? key,
    this.width,
    this.textFieldColor,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.controller,
    this.showPrefixIcon = true,
    this.showSuffixIcon = true,
    this.prefixText,
    this.prefixWidget,
    this.suffixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.maxLength,
    this.maxLines = 1,
    this.inputBorder,
    this.inputFormatter,
    this.autoFocus = false,
    this.focusNode,
    this.validator,
    this.cursorColor,
    this.validate,
    this.readOnly = false,
    this.showCounterText = false,
    this.borderRadius = 0,
    this.filled = true,
    this.fillColor = DropAndGoColors.white,
    this.errorHeight,
    this.disableSpacing = false,
    this.autoValidateMode,
  }) : super(key: key);

  final double? width;
  final Color? textFieldColor;
  final Color? borderColor;
  final Color? cursorColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final Widget? prefixWidget;
  final String? prefixText;
  final Widget? suffixWidget;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final void Function()? onEditingComplete;

  final bool showPrefixIcon;
  final bool showCounterText;
  final bool showSuffixIcon;
  final bool isEnabled;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autoCorrect;
  final int? maxLength;
  final int? maxLines;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final InputBorder? inputBorder;
  final List<TextInputFormatter>? inputFormatter;
  final bool autoFocus;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final bool? validate;
  final bool readOnly;
  final double borderRadius;
  final Color fillColor;
  final bool filled;
  final double? errorHeight;
  final bool? disableSpacing;
  final AutovalidateMode? autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      style: labelStyle??DropAndGoTextStyle.hintStyle.copyWith(
        // color: LocalWalkersColors.black,
      ),
      decoration: InputDecoration(
        fillColor: fillColor,
        counterText: maxLength != null ? '' : null,
        counterStyle: DropAndGoTextStyle.bodyText2,
        filled: filled,
        errorStyle: hintStyle??TextStyle(
          color: Colors.red,
          height: errorHeight,
          fontSize: 11,
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle??DropAndGoTextStyle.hintStyle,
        border: inputBorder ??
            UnderlineInputBorder(
              borderSide: const BorderSide(
                color: DropAndGoColors.black,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        focusedBorder: inputBorder ??
            UnderlineInputBorder(
              borderSide: const BorderSide(
                color: DropAndGoColors.black,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        errorBorder: inputBorder ??
            UnderlineInputBorder(
              borderSide: const BorderSide(
                color: DropAndGoColors.red,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        disabledBorder: inputBorder ??
            UnderlineInputBorder(
              borderSide: const BorderSide(
                color: DropAndGoColors.primary,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        enabledBorder: inputBorder ??
            UnderlineInputBorder(
              borderSide: const BorderSide(
                color: DropAndGoColors.primary,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),

        labelStyle: labelStyle??DropAndGoTextStyle.bodyText2.copyWith(
          color: (focusNode != null &&
                  focusNode!.hasFocus &&
                  validate != null &&
                  !validate!)
              ? Colors.red
              : (focusNode != null &&
                      focusNode!.hasFocus &&
                      validate != null &&
                      validate!)
                  ? DropAndGoColors.primary
                  : const Color(0xFF4B5563),
        ),
        suffixIcon: showSuffixIcon ? suffixWidget : null,
        prefixIcon: showPrefixIcon ? prefixWidget : null,
        prefixText: prefixText,
        prefixStyle: DropAndGoTextStyle.bodyText1.copyWith(
          fontSize: 14.flexibleFontSize,
          color: DropAndGoColors.primary,
        ),
      ),
      controller: controller,
      textAlign: textAlign,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      enabled: isEnabled,
      inputFormatters: disableSpacing!
          ? [
              FilteringTextInputFormatter.deny(
                RegExp(r'\s'),
              ),
            ]
          : inputFormatter ?? [NoLeadingSpaceFormatter()],
      autofocus: autoFocus,
      focusNode: focusNode,
      validator: validator,
      cursorColor: cursorColor ?? DropAndGoColors.black,
      autovalidateMode:
          autoValidateMode ?? AutovalidateMode.onUserInteraction,
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String timedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: timedText,
        selection: TextSelection(
          baseOffset: timedText.length,
          extentOffset: timedText.length,
        ),
      );
    }

    return newValue;
  }
}


class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.contains(' ')) {
    return oldValue;
    }else if(newValue.text.contains('.') || newValue.text.contains(',')){
      return newValue;
    }

    return newValue;
  }
}
