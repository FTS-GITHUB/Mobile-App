import 'dart:async';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/local_auth_service.dart';
import 'package:dropandgouser/infrastructure/splash/splash_repository.dart';
import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/src/either.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this.authRepository,
    this.splashRepository,
  ) : super(SplashStateInitial()) {
    on<CheckAuthState>(_onCheckAuthState);
    on<AuthenticateBiometric>(_onAuthenticateBiometric);
  }

  final IAuthRepository authRepository;
  final SplashRepository splashRepository;

  Future<void> _onCheckAuthState(
      CheckAuthState event, Emitter<SplashState> emit) async {
    emit(SplashStateLoading());
    bool isBiometricEnabled = SharedPreferenceHelper.isBiometricEnabled;
    if (isBiometricEnabled && !(event.isAuthenticated)) {
      add(AuthenticateBiometric());
    } else {
      await authRepository.getSignedInUser().catchError((err) {
        emit(
          SplashStateError(
            message: err.toString(),
          ),
        );
      }).then((value) {
        if (value == null) {
          emit(SplashStateUnauthenticated());
        } else {
          debugPrint(value.uid);
          getIt<UserService>().userData = UserData(id: value.uid);
          debugPrint('User id is:: ${getIt<UserService>().userData?.id}');
          emit(SplashStateAuthenticated());
        }
      });
    }
  }

  Future<void> _onAuthenticateBiometric(
    AuthenticateBiometric event,
    Emitter<SplashState> emit,
  ) async {
    final Either<ApiError, bool> localAuthResponse =
        await LocalAuthService.initialize();
    localAuthResponse.fold(
      (l) => emit(
        SplashStateError(
          message: l.message ?? "Failed to connect",
        ),
      ),
      (r) => add(
        CheckAuthState(
          isAuthenticated: r,
        ),
      ),
    );
  }
}
