import 'package:dropandgouser/application/session/session_cubit/session_completed_cubit.dart';
import 'package:dropandgouser/dropandgo_app.dart';
import 'package:dropandgouser/firebase_options.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(
    const Duration(
      seconds: 1,
    ),
  );
  registerServices();
  runApp(
    const DropAndGoApp(),
  );
}