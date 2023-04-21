// ignore_for_file: unnecessary_import, implementation_imports

import 'package:dropandgouser/domain/login/i_login_repository.dart';
import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';

class LoginRepository extends ILoginRepository {
  LoginRepository({
    required this.authRepository,
  });

  final IAuthRepository authRepository;

  @override
  Future<Either<ApiError, String>> login(
      {required String email, required String password}) async {
    return await authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<ApiError, Unit>> resetPassword({required String email})async {
    return await authRepository.resetPassword(
      email: email,
    );
  }


}
