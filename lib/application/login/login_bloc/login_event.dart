part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUser extends LoginEvent {
  LoginUser({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class LoginUserWithGmail extends LoginEvent {
  LoginUserWithGmail();
}

class SendResetEmail extends LoginEvent {
  SendResetEmail({
    required this.email,
  });

  final String email;
}

class LogoutUser extends LoginEvent {
  LogoutUser();
}
