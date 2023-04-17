import 'dart:async';

import 'package:dropandgouser/domain/login/i_login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

part 'login_event.dart';

mixin ForgetPasswordBloc on Bloc<LoginEvent, LoginState>{}

class LoginBloc extends Bloc<LoginEvent, LoginState> with ForgetPasswordBloc{
  LoginBloc({
    required this.loginRepository,
  }) : super(LoginStateInitial()) {
    on<LoginUser>(_onLoginUser);
    on<SendResetEmail>(_onSendResetEmail);
  }

  final ILoginRepository loginRepository;

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

  Future<void> _onSendResetEmail(SendResetEmail event, Emitter<LoginState> emit) async{
   emit(ForgetPasswordSendingEmail());
   final response = await loginRepository.resetPassword(email: event.email);
   response.fold(
         (l) => emit(LoginStateError(message: l.message ?? "Error from server")),
         (r) => emit(
       ForgetPasswordSentEmail(),
     ),
   );
  }
}
