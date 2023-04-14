part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUser extends LoginEvent{
  LoginUser({
    required this.email,
    required this.password,
});

  final String email;
  final String password;
}