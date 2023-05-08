part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateLoaded extends UserState {
  UserStateLoaded({
    required this.userData,
    required this.userSetting,
  });

  final UserData userData;
  final UserSetting userSetting;
}

class UserStateError extends UserState {
  UserStateError({
    required this.message,
  });

  final String message;
}
