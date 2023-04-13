import 'dart:async';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/src/unit.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SignupStateInitial()) {
    on<CreateNewAccount>(_onCreateNewAccount);
  }

  final IAuthRepository _authRepository;

  Future<void> _onCreateNewAccount(
      CreateNewAccount event, Emitter<SignupState> emit) async {
    emit(SignupStateCreatingAccount());
    final response = await _authRepository.registerWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (ApiError l) => emit(
        SignupStateError(
          message: l.message ?? 'Error',
        ),
      ),
      (Unit r) => emit(
        SignupStateCreatedAccount(),
      ),
    );
  }
}
