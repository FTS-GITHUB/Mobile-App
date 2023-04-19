import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StandardText.headline2(context, "Downloads"),
    );
  }
}
