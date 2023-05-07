import 'dart:async';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/splash/splash_repository.dart';
import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this.authRepository,
    this.splashRepository,
  ) : super(SplashStateInitial()) {
    on<CheckAuthState>(_onCheckAuthState);
    on<GetUserSettings>(_onGetUserSettings);
  }

  final IAuthRepository authRepository;
  final SplashRepository splashRepository;

  Future<void> _onCheckAuthState(
      CheckAuthState event, Emitter<SplashState> emit) async {
    emit(SplashStateLoading());
    UserData? userData = await SharedPreferenceHelper.getUser();
    if (userData != null) {
      // User data is found locally
      getIt<UserService>().userData = userData;
      // add event to get user settings;
      add(
        GetUserSettings(
          userId: userData.id!,
        ),
      );
    } else {
      User? user = await authRepository.getSignedInUser();
      // if(user !=null) {
      //   emit(SplashStateAuthenticated());
      // } else {
      //   emit(SplashStateUnauthenticated());
      // }
    }
  }

  Future<void> _onGetUserSettings(
      GetUserSettings event, Emitter<SplashState> emit) async {
    final response =
        await splashRepository.getUserSettings(userid: event.userId);
    response.fold((l) => emit(SplashStateError(message: l.message?? 'Failed to connect')), (r){

    } );
  }
}
