import 'package:dropandgouser/presentation/signup/widgets/success_placeholder_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessPlaceholder extends StatelessWidget {
  const SuccessPlaceholder({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        width??173.w,
        height??(166 * 0.9595375722543352).toDouble().h,
      ),
      painter: SuccessPlaceholderPainter(),
    );
  }
}
