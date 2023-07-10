import 'dart:async';

import 'package:dropandgouser/domain/login/i_login_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/i_signup_repository.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/enums/gender.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

mixin ForgetPasswordBloc on Bloc<LoginEvent, LoginState> {}

class LoginBloc extends Bloc<LoginEvent, LoginState> with ForgetPasswordBloc {
  LoginBloc({
    required this.loginRepository,
    required this.signupRepository,
  }) : super(LoginStateInitial()) {
    on<LoginUser>(_onLoginUser);
    on<SendResetEmail>(_onSendResetEmail);
    on<LogoutUser>(_onLogoutUser);
    on<LoginUserWithGmail>(_onLoginUserWithGmail);
    on<UpdateSocialLoginUser>(_onUpdateSocialLoginUser);
    on<UpdateSocialLoginSetting>(_onUpdateSocialLoginSetting);
  }

  final ILoginRepository loginRepository;
  final ISignupRepository signupRepository;

  FutureOr<void> _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginStateLoading());
    final response = await loginRepository.login(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (l) => emit(LoginStateError(message: l.message ?? "Error from server")),
      (r) => emit(
        LoginStateLoaded(),
      ),
    );
  }

  Future<void> _onSendResetEmail(
      SendResetEmail event, Emitter<LoginState> emit) async {
    emit(ForgetPasswordSendingEmail());
    final response = await loginRepository.resetPassword(email: event.email);
    response.fold(
      (l) => emit(LoginStateError(message: l.message ?? "Error from server")),
      (r) => emit(
        ForgetPasswordSentEmail(),
      ),
    );
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<LoginState> emit) async {
    emit(LoginStateLoading());
    final response = await loginRepository.logout();
    response.fold(
      (l) => emit(
        LoginStateError(
          message: l.message ?? "Failed to connect",
        ),
      ),
      (r) => emit(
        LogoutSuccess(),
      ),
    );
  }

  Future<void> _onLoginUserWithGmail(
      LoginUserWithGmail event, Emitter<LoginState> emit) async {
    emit(LoginStateLoading());
    final response = await loginRepository.loginWithGmail();
    response.fold(
      (l) => emit(
        LoginStateError(
          message: l.message ?? "Failed to connect",
        ),
      ),
      (UserCredential userCredential) {
        add(UpdateSocialLoginUser(
          userCredential: userCredential,
        ));
      },
    );
  }

  Future<void> _onUpdateSocialLoginUser(
      UpdateSocialLoginUser event, Emitter<LoginState> emit) async {
    if (event.userCredential.user?.uid == null) {
      emit(LoginStateError(message: "Failed to login. please try again"));
    }else{
      UserData userData = UserData(
        id: event.userCredential.user?.uid,
        email: event.userCredential.user?.email,
        createdAt: DateTime.now(),
        profilePicUrl: event.userCredential.user?.photoURL,
        fullName: event.userCredential.user?.displayName,
        likedCategories: [],
        gender: GenderEnum.Other.name,
        isDeleted: false,
        signInMethod: event.userCredential.credential?.signInMethod,
      );
      final response = await signupRepository.uploadDataWithFirestore(
        collectionName: FirestoreCollections.users,
        docId: event.userCredential.user!.uid,
        userData: userData,
      );
      response.fold(
            (l) => emit(
          LoginStateError(
            message: l.message ?? "Failed to connect",
          ),
        ),
            (UserData r) {
              getIt<UserService>().userData = r;
              add(UpdateSocialLoginSetting(
                userId: r.id!
              ));
        },
      );
    }
  }

  Future<void> _onUpdateSocialLoginSetting(UpdateSocialLoginSetting event, Emitter<LoginState> emit) async{
    UserSetting userSetting =UserSetting();
    final response = await signupRepository.uploadUserSetting(
      docId: event.userId,
      userSetting: userSetting,
    );
    response.fold(
          (l) => emit(
        LoginStateError(
          message: l.message ?? "Failed to connect",
        ),
      ),
          (UserSetting r) {
        getIt<UserService>().userSetting = r;
        emit(
          LoggedInWithSocial(),
        );
      },
    );
  }
}

