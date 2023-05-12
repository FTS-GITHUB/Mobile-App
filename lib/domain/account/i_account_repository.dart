import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class IAccountRepository{
  Future<Either<ApiError, Unit>> updatePersonalInfo({
    required UserData userData,
});
}