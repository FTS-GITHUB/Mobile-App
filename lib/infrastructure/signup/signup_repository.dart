import 'dart:io';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/i_storage_repository.dart';
import 'package:dropandgouser/domain/signup/i_signup_repository.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';

class SignupRepository extends ISignupRepository{
  SignupRepository({
    required this.authRepository,
    required this.firestoreRepository,
    required this.storageRepository,
});
  final IAuthRepository authRepository;
  final ICloudFirestoreRepository firestoreRepository;
  final IStorageRepository storageRepository;

  @override
  Future<Either<ApiError, Unit>> registerUserWithAuth({required String email, required String password}) {

  }

  @override
  Future<Either<ApiError, UserData>> uploadDataWithFirestore({required String collectionName, required String docId, required object}) {
    // TODO: implement uploadDataWithFirestore
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, String>> uploadUserProfilePic({required String path, required File file}) {
    // TODO: implement uploadUserProfilePic
    throw UnimplementedError();
  }

}