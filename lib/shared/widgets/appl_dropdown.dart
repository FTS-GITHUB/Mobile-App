import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/helpers/typography/text_styles.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropAndGoDropdown<T> extends StatelessWidget {
  const DropAndGoDropdown({
    Key? key,
    this.value,
    required this.hintText,
    required this.onChanged,
    this.validator,
    required this.data,
  }) : super(key: key);
  final T? value;
  final String hintText;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // decoration: const BoxDecoration(
      //   // border: Border.all(color: LocalWalkersColors.inputFieldFill),
      //   // borderRadius: BorderRadius.circular(8.0),
      //   // color: LocalWalkersColors.inputFieldFill,
      // ),
      height: 50.0,
      // padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(),
          errorBorder: const UnderlineInputBorder(),
          disabledBorder: const UnderlineInputBorder(),
          hintStyle: DropAndGoTextStyle.bodyText2,
          border: InputBorder.none,
          // errorStyle: LocalWalkersTextStyle.subtitle3.copyWith(color: LocalWalkersColors.red,),
        ),
        value: value,
        hint: StandardText.body1(
          context,
          hintText,
          color: DropAndGoColors.black,
        ),
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        icon: Transform.scale(
          scale: .8,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset(
              DropAndGoIcons.arrowDown,
            ),
          ),
        ),
        // icon: const Icon(
        //   Icons.keyboard_arrow_down,
        // ),
        // borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        style: DropAndGoTextStyle.subtitle3.copyWith(
          fontWeight: FontWeight.w400,
        ),
        items: data,
      ),
    );
  }
}
