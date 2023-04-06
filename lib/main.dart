import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/dropandgo_app.dart';
import 'package:dropandgouser/shared/screen_util/screen_util_setup.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  registerServices();
  runApp(
    const ScreenUtilSetup(
      child: DropAndGoApp(),
    ),
  );
}
