import 'package:dropandgouser/presentation/signup/widgets/success_placeholder_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessPlaceholder extends StatelessWidget {
  const SuccessPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        173.w,
        (166 * 0.9595375722543352).toDouble().h,
      ),
      painter: SuccessPlaceholderPainter(),
    );
  }
}
