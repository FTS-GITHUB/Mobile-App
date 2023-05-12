part of 'account_setting_bloc.dart';

abstract class AccountSettingEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UpdateUserSetting extends AccountSettingEvent{
  UpdateUserSetting({
    required this.userSetting,
});

  final UserSetting userSetting;
}