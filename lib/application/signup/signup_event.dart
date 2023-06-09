part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNewAccount extends SignupEvent {
  CreateNewAccount({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class UploadUserData extends SignupEvent {
  UploadUserData({
    required this.userData,
    required this.userSetting,
    required this.userId,
  });

  final UserData userData;
  final UserSetting userSetting;
  final String userId;
}

class UploadProfilePicture extends SignupEvent {
  UploadProfilePicture({
    required this.file,
    required this.userId,
  });

  final File file;
  final String userId;
}

class UploadUserSetting extends SignupEvent {
  UploadUserSetting({
    required this.userSetting,
    required this.userId,
  });

  final UserSetting userSetting;
  final String userId;
}

class SaveSettingsLocally extends SignupEvent {
  SaveSettingsLocally({
    required this.userSetting,
  });

  final UserSetting userSetting;
}
