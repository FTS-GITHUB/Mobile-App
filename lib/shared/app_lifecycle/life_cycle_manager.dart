// ignore_for_file: avoid_print

import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/local_database_service.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<LifeCycleManager> createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    localDatabaseService??LocalDatabaseService();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      final user = getIt<UserService>().userData;
      if (user?.id != null) {
        print("User id: ${user?.id}");
        DateTime now = DateTime.now();
        var elapsedDuration = stopWatch.elapsedDuration as Duration;
        localDatabaseService!.recordSession(
          session: Session(
            id: DateTime(
              now.year,
              now.month,
              now.day,
            ).millisecondsSinceEpoch.toString(),
            appUseDuration: '${stopWatch.elapsedDuration}',
            sessionDate: DateTime(
              now.year,
              now.month,
              now.day,
            ).millisecondsSinceEpoch,
            isSessionCompleted: elapsedDuration.inMinutes>10?true:false,
          ),
        );
      }
    } else if (state == AppLifecycleState.resumed) {
      stopWatch.start();
    }
    print('AppLifecycleState: $state');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
