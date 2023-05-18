import 'dart:async';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(ChangePasswordStateInitial()) {
    on<UpdatePassword>(_onUpdatePassword);
  }

  final IAuthRepository _authRepository;

  Future<void> _onUpdatePassword(
      UpdatePassword event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordStateLoading());
    final response = await _authRepository.updatePassword(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
    );
    response.fold(
      (l) => emit(
        ChangePasswordStateError(
          message: l.message ?? "Failed to connect",
        ),
      ),
      (r) => emit(
        ChangePasswordStateLoaded(),
      ),
    );
  }
}
