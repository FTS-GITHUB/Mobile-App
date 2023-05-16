import 'dart:async';

import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused || state == AppLifecycleState.paused){
      stopWatch.stop();
      final user = getIt<UserService>().userData;
      if(user?.id != null){
        print("User id: ${user?.id}");
      }
      print(stopWatch.elapsedDuration);
    }else if (state == AppLifecycleState.resumed){
      stopWatch.start();
      print(stopWatch.elapsedDuration);
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
