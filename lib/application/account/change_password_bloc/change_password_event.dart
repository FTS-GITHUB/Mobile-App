part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePassword extends ChangePasswordEvent {
  UpdatePassword({
    required this.oldPassword,
    required this.newPassword,
  });
final String oldPassword;
final String newPassword;
}
