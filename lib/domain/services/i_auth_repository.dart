import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract class IAuthRepository {
  Future<User?> getSignedInUser();

  Future<void> signOut();

  Future<Either<ApiError, String>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<ApiError, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  String? get userId;

  Future<Either<ApiError, Unit>> resetPassword({
    required String email,
  });

  Future<Either<ApiError, Unit>> updatePassword({
    required String oldPassword,
    required String newPassword,
});

  Future<Either<ApiError, UserCredential>> signInWithGoogle();
}