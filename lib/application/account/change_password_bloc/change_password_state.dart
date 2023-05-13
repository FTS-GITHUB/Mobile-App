part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordStateInitial extends ChangePasswordState {}

class ChangePasswordStateLoading extends ChangePasswordState {
}

class ChangePasswordStateLoaded extends ChangePasswordState {
  ChangePasswordStateLoaded();
}

class ChangePasswordStateError extends ChangePasswordState {
  ChangePasswordStateError({
    required this.message,
  });

  final String message;
}
