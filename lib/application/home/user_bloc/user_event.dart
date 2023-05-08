part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUser extends UserEvent {
  FetchUser();
}

class FetchUserSetting extends UserEvent {
  FetchUserSetting({
    required this.userId,
    required this.userData,
  });

  final UserData userData;
  final String? userId;
}
