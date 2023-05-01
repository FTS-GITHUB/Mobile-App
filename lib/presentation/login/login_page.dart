import 'package:dropandgouser/presentation/login/login_form.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          // leading: IconButton(
          //   icon: SvgPicture.asset(
          //     DropAndGoIcons.arrowBack,
          //   ),
          //   onPressed: () {
          //     getIt<NavigationService>().navigateBack(context: context);
          //   },
          // ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        child: LoginForm(
          emailTextEditingController: emailTextEditingController,
          passwordTextEditingController: passwordTextEditingController,
          formKey: _formKey,
        ),
      ),
    );
  }
}
