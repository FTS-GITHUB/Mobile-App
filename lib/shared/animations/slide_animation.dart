import 'package:flutter/material.dart';

class SlideInAnimation extends StatelessWidget {
  const SlideInAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 10, end: 0),
      builder: (BuildContext context, double padding, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(
            top: padding,
          ),
          child: child!,
        );
      },
      duration: const Duration(milliseconds: 700),
      child: child,
    );
  }
}
