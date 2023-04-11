import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DropAndGoButtonLoading extends StatelessWidget {
  const DropAndGoButtonLoading({
    super.key,
    this.color = DropAndGoColors.primary,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  SpinKitCircle(
        color: DropAndGoColors.primary,
        size: 55,
      ),
    );
  }
}
