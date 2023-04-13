import 'dart:async';

import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/di/injectable.dart';

class SplashIndexCubit extends Cubit<double>{
  SplashIndexCubit():super(0);

  onTimerChanged(Timer timer, BuildContext context){
    if (state >= 1) {
      timer.cancel();
      getIt<NavigationService>().replaceWithNamed(
        context: context,
        uri: NavigationService.onboardingGenderRouteUri,
      );
    } else {
      emit(state + 0.1);
    }
  }

}