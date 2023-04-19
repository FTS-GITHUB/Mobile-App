import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/cupertino.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StandardText.headline2(context, "Accounts"),
    );
  }
}
