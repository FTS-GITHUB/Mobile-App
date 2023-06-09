part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {}

class LogoutSuccess extends LoginState {}

class LoggedInWithSocial extends LoginState {}

class ForgetPasswordSendingEmail extends LoginState{}

class ForgetPasswordSentEmail extends LoginState{}

class LoginStateError extends LoginState {
  LoginStateError({
    required this.message,
  });

  final String message;
}
