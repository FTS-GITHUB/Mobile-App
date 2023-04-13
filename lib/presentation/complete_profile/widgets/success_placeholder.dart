import 'package:dropandgouser/presentation/complete_profile/widgets/success_placeholder_painter.dart';
import 'package:flutter/material.dart';

class SuccessPlaceholder extends StatelessWidget {
  const SuccessPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        173,
        (166 * 0.9595375722543352).toDouble(),
      ),
      painter: SuccessPlaceholderPainter(),
    );
  }
}
