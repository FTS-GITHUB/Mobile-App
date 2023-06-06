import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract class ILoginRepository {
  Future<Either<ApiError, String>> login({
    required String email,
    required String password,
});

  Future<Either<ApiError, UserData>> getUser({required String id});

  Future<Either<ApiError, Unit>> resetPassword({
    required String email,
  });

  Future<Either<ApiError, Unit>> logout();

  Future<Either<ApiError, UserCredential>> loginWithGmail();
}