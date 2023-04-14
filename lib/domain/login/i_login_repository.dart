import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class ILoginRepository {
  Future<Either<ApiError, String>> login({
    required String email,
    required String password,
}); 
}