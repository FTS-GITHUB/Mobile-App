part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UpdatePersonalInfo extends PersonalInfoEvent{
  UpdatePersonalInfo({
    required this.userData,
    this.fileImage
});
  final UserData userData;
  final File? fileImage;
}

class UpdateProfilePic extends PersonalInfoEvent{
  UpdateProfilePic({
    required this.userData,
    required this.fileImage,
  });

  UserData userData;
  final File fileImage;
}
