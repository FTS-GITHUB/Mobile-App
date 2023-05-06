// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';

import 'package:dropandgouser/domain/signup/i_signup_repository.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';

part 'signup_state.dart';

mixin PostSignupBloc on Bloc<SignupEvent, SignupState> {}

mixin UploadPictureSignupBloc on Bloc<SignupEvent, SignupState> {}

class SignupBloc extends Bloc<SignupEvent, SignupState>
    with PostSignupBloc, UploadPictureSignupBloc {
  SignupBloc({
    required ISignupRepository signupRepository,
  })  : _signupRepository = signupRepository,
        super(SignupStateInitial()) {
    on<CreateNewAccount>(_onCreateNewAccount);
    on<UploadUserData>(_onUploadUserData);
    on<UploadProfilePicture>(_onUploadProfilePicture);
    on<UploadUserSetting>(_onUploadUserSetting);
  }

  final ISignupRepository _signupRepository;

  Future<void> _onCreateNewAccount(
      CreateNewAccount event, Emitter<SignupState> emit) async {
    emit(SignupStateCreatingAccount());
    final response = await _signupRepository.registerUserWithAuth(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (ApiError l) {
        emit(
          SignupStateError(
            message: l.message ?? 'Error',
          ),
        );
      },
      (String r) {
        emit(
        SignupStateCreatedAccount(
          userId: r,
        ),
      );
      },
    );
  }

  Future<void> _onUploadUserData(
      UploadUserData event, Emitter<SignupState> emit) async {
    emit(SignupStateCreatingAccount());
    final response = await _signupRepository.uploadDataWithFirestore(
      collectionName: FirestoreCollections.users,
      docId: event.userId,
      userData: event.userData,
    );
    response.fold(
      (l) => emit(SignupStateError(message: l.message ?? 'Error1')),
      (r) async{
        add(UploadUserSetting(
        userSetting: event.userSetting,
        userId: event.userId,
      ));
        await SharedPreferenceHelper.saveUser(r);
      },
    );
  }

  Future<void> _onUploadProfilePicture(
      UploadProfilePicture event, Emitter<SignupState> emit) async {
    emit(SignupStateCreatingAccount());
    final response = await _signupRepository.uploadUserProfilePic(
      file: event.file,
    );
    response.fold(
      (l) => emit(SignupStateError(message: l.message ?? 'Error1')),
      (r) => emit(
        SignupStateUploadedPicture(
          profilePicUrl: r,
          userId: event.userId,
        ),
      ),
    );
  }

  Future<void> _onUploadUserSetting(
      UploadUserSetting event, Emitter<SignupState> emit) async {
    final response = await _signupRepository.uploadUserSetting(
      docId: event.userId,
      userSetting: event.userSetting,
    );
    response.fold(
      (l) => emit(SignupStateError(message: l.message ?? 'Error1')),
      (r) async{
        await SharedPreferenceHelper.saveUserSetting(event.userSetting);
        emit(
        SignupStateUploadedData(),
      );
      },
    );
  }
}
