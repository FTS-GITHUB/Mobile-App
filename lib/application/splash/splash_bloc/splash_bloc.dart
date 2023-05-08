import 'dart:async';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/splash/splash_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this.authRepository,
    this.splashRepository,
  ) : super(SplashStateInitial()) {
    on<CheckAuthState>(_onCheckAuthState);
    // on<GetUserSettings>(_onGetUserSettings);
    // on<GetUser>(_onGetUser);
  }

  final IAuthRepository authRepository;
  final SplashRepository splashRepository;

  Future<void> _onCheckAuthState(
      CheckAuthState event, Emitter<SplashState> emit) async {
    emit(SplashStateLoading());
    await authRepository.getSignedInUser().catchError(
        (err){
          emit(SplashStateError(message: err.toString(),),);
        }
    ).then((value){
      if(value==null){
        emit(SplashStateUnauthenticated());
      }else{
        debugPrint(value.uid);
        getIt<UserService>().userData= UserData(id: value.uid);
        debugPrint('User id is:: ${getIt<UserService>().userData?.id}');
        emit(SplashStateAuthenticated());
      }
    });
    // SharedPreferenceHelper.deletePreferences(PreferencesKey.userKey);
    // UserData? userData = await SharedPreferenceHelper.getUser();
    // if (userData != null && userData.id!=null) {
    //   print(userData.toJson());
    //   // User data is found locally
    //   getIt<UserService>().userData = userData;
    //   // add event to get user settings;
    //   add(
    //     GetUserSettings(
    //       userId: userData.id!,
    //     ),
    //   );
    // } else {
    //   // in case local db is not found it will get data from
    //   User? user = await authRepository.getSignedInUser();
    //   if (user == null) {
    //     emit(SplashStateUnauthenticated());
    //   } else {
    //     add(
    //       GetUser(
    //         userId: user.uid,
    //       ),
    //     );
    //   }
    // }
  }
}
