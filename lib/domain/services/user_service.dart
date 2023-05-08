import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';

class UserService {
  UserService({
    this.userData,
    this.userSetting,
  });

  UserService copyWith({
    UserData? userData,
    UserSetting? userSetting,
  }) =>
      UserService(
        userData: userData ?? this.userData,
        userSetting: userSetting ?? this.userSetting,
      );

  UserData? userData;
  UserSetting? userSetting;
}
