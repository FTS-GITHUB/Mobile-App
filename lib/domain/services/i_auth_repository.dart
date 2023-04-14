import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class IAuthRepository {

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

// Future<Either<ApiError, Unit>> signInWithGoogle();
}