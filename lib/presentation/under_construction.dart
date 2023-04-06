import 'package:dropandgouser/shared/widgets/base_scaffold.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: const Text('Under construction'),
      ),
      body: Center(
        child: StandardText.headline4(
          context,
          'Page is under construction',
        ),
      ),
    );
  }
}
