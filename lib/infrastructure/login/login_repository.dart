// ignore_for_file: unnecessary_import, implementation_imports

import 'package:dropandgouser/domain/login/i_login_repository.dart';
import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';

class LoginRepository extends ILoginRepository {
  LoginRepository({
    required this.authRepository,
    required this.firestoreRepository,
  });

  final IAuthRepository authRepository;
  final ICloudFirestoreRepository firestoreRepository;

  @override
  Future<Either<ApiError, String>> login(
      {required String email, required String password}) async {
    return await authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<ApiError, Unit>> resetPassword({required String email}) async {
    return await authRepository.resetPassword(
      email: email,
    );
  }

  @override
  Future<Either<ApiError, Unit>> logout() async {
    try {
      await authRepository.signOut();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(
        e.toApiError(),
      );
    }
  }

  @override
  Future<Either<ApiError, UserCredential>> loginWithGmail() async {
    return await authRepository.signInWithGoogle();
  }

  @override
  Future<Either<ApiError, UserData>> getUser({required String id}) async {
    final response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.users,
      docId: id,
    );
    return response.fold(
          (l) => left(l.toApiError()),
          (r) {
        UserData userData = UserData.fromJson(
          r.data() ?? {},
        );
        getIt<UserService>().userData = userData;
        return right(userData);
      },
    );
  }
}
