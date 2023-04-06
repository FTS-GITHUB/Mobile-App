import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';

class LocalWalkerButtonLoading extends StatelessWidget {
  const LocalWalkerButtonLoading({
    super.key,
    this.color = DropAndGoColors.primary,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
