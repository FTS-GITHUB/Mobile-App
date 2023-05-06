import 'package:dropandgouser/dropandgo_app.dart';
import 'package:dropandgouser/firebase_options.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/screen_util/screen_util_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(
    Duration(
      seconds: 1,
    ),
  );
  registerServices();
  runApp(
    const ScreenUtilSetup(
      child: DropAndGoApp(),
    ),
  );
}
