import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class IAccountRepository{
  Future<Either<ApiError, Unit>> updatePersonalInfo({
    required UserData userData,
});

  Future<Either<ApiError, Unit>> updateUserSetting({
    required String userId,
    required UserSetting userSetting,
  });
}