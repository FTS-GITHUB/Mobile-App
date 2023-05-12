part of 'account_setting_bloc.dart';

abstract class AccountSettingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountSettingStateInitial extends AccountSettingState {}

class AccountSettingStateLoading extends AccountSettingState {
}

class AccountSettingStateLoaded extends AccountSettingState {
  AccountSettingStateLoaded({
    required this.userSetting,
});

  final UserSetting userSetting;
}

class AccountSettingStateError extends AccountSettingState {
  AccountSettingStateError({
    required this.message,
  });

  final String message;
}
