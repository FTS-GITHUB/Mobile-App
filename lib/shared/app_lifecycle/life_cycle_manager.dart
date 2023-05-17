import 'package:dropandgouser/application/session/session_bloc/session_bloc.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (state == AppLifecycleState.inactive) {
      final user = getIt<UserService>().userData;
      if (user?.id != null) {
        print("User id: ${user?.id}");
        DateTime now = DateTime.now();
        context.read<SessionBloc>().add(UploadSession(
          userId: user!.id!,
          session: Session(
            appUseDuration: '${stopWatch.elapsedDuration}',
            sessionDate: DateTime(
              now.year,
              now.month,
              now.day,
            ),
          ),
        ));
      }
      // Duration duration1 = Duration(seconds: 1800);
      // Duration duration = stopWatch.elapsedDuration as Duration;
      // Duration addedDuration = duration + duration1;
      // print('Duration in minutes ${duration.inMinutes}');
      // print('Duration in HH MM SS: ${formatDurationInHhMmSs(addedDuration)}');
      // print(stopWatch.elapsedDuration);
    } else if (state == AppLifecycleState.resumed) {
      stopWatch.reset();
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
