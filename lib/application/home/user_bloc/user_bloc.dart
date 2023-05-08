import 'dart:async';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/splash/splash_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/di/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required this.authRepository,
    required this.splashRepository,
  }) : super(UserStateInitial()) {
    on<FetchUser>(_onFetchUser);
    on<FetchUserSetting>(_onFetchUserSetting);
  }

  final IAuthRepository authRepository;
  final SplashRepository splashRepository;

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    if (authRepository.userId == null) {
      emit(
        UserStateError(
          message: 'You are not authorized',
        ),
      );
    } else {
      final response = await splashRepository.getUser(userid: authRepository.userId!);
      response.fold(
        (l) => emit(
          UserStateError(
            message: l.message ?? 'Failed to connect',
          ),
        ),
        (r) {
          getIt<UserService>().userData = r;
          add(
            FetchUserSetting(
              userData: r,
              userId: authRepository.userId,
            ),
          );
        },
      );
    }
  }

  Future<void> _onFetchUserSetting(
      FetchUserSetting event, Emitter<UserState> emit) async {
    final response = await splashRepository.getUserSettings(
      userid: event.userId!,
    );
    response.fold(
      (l) => emit(
        UserStateError(
          message: l.message ?? "Failed to connect",
        ),
      ),
      (r) {
        getIt<UserService>().userSetting = r;
        emit(UserStateLoaded(
          userData: event.userData,
          userSetting: r,
        ));
      },
    );
  }
}
