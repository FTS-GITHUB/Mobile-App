import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    this.onSelected,
  }) : super(key: key);
  final void Function(int)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black12,
        padding: const EdgeInsets.only(
          top: 100,
          left: 12,
          right: 12,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.account_box_outlined,
                ),
                // 5.horizontalGap,
                StandardText.body2(
                  context,
                  'My account',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.account_box_outlined,
                ),
                // 5.horizontalGap,
                StandardText.body2(
                  context,
                  'My account',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
