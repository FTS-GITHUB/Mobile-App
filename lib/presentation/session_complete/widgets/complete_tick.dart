import 'package:dropandgouser/presentation/session_complete/widgets/complete_tick_painter.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:flutter/material.dart';

class CompleteTick extends StatelessWidget {
  const CompleteTick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(context.width/2.5, ((context.width/2.5)*0.9595375722543352).toDouble()),
      painter: CompleteTickPainter(),
    );
  }
}
