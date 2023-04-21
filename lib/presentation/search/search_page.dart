import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: const StandardTextField(
            prefixWidget: Icon(
              Icons.search,
              color: DropAndGoColors.white,
            ),
            fillColor: DropAndGoColors.primary,
          ),
        ),
      ),
    );
  }
}
