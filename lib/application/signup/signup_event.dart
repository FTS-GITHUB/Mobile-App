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
  });

  final UserData userData;
}

class UploadProfilePicture extends SignupEvent {
  UploadProfilePicture({
    required this.file,
});
  final File? file;
}
