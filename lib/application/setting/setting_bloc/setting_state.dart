part of 'setting_bloc.dart';

abstract class SettingState {}

class SettingStateInitial extends SettingState {}

class SettingStateLoading extends SettingState {}

class SettingStateLoaded extends SettingState {
  SettingStateLoaded({
    this.setting,
  });

  final DropAndGoSetting? setting;
}

class SettingStateError extends SettingState {
  SettingStateError({
    required this.message,
  });

  final String message;
}
