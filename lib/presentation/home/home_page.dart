import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StandardText.headline6(
          context,
          "Welcome to Home page",
        ),
      ),
    );
  }
}
