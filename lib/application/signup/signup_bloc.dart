import 'dart:async';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/src/unit.dart';

part 'signup_event.dart';

part 'signup_state.dart';

mixin PostSignupBloc on Bloc<SignupEvent, SignupState> {}

class SignupBloc extends Bloc<SignupEvent, SignupState> with PostSignupBloc {
  SignupBloc({
    required IAuthRepository authRepository,
    required ICloudFirestoreRepository firestoreRepository,
  })  : _authRepository = authRepository,
        _firestoreRepository = firestoreRepository,
        super(SignupStateInitial()) {
    on<CreateNewAccount>(_onCreateNewAccount);
    on<UploadUserData>(_onUploadUserData);
  }

  final IAuthRepository _authRepository;
  final ICloudFirestoreRepository _firestoreRepository;

  Future<void> _onCreateNewAccount(
      CreateNewAccount event, Emitter<SignupState> emit) async {
    emit(SignupStateCreatingAccount());
    final response = await _authRepository.registerWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (ApiError l) {
        print(l.code);
        emit(
        SignupStateError(
          message: l.message ?? 'Error',
        ),
      );
      },
      (Unit r) => emit(
        SignupStateCreatedAccount(),
      ),
    );
  }

  Future<void> _onUploadUserData(
      UploadUserData event, Emitter<SignupState> emit) async {
    emit(SignupStateCreatingAccount());
    final String? docId = _authRepository.userId;
    if (docId == null) {
      return;
    }
    final response = await _firestoreRepository.uploadData(
      collectionName: FirestoreCollections.users,
      docId: docId,
      object: event.userData.copyWith(id: docId).toJson(),
    );
    response.fold(
        (l) => emit(SignupStateError(message: l.message ?? 'Error1')),
        (r) => emit(
              SignupStateUploadedData(),
            ));
  }
}
