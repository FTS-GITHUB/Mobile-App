// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/i_storage_repository.dart';
import 'package:dropandgouser/domain/signup/i_signup_repository.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/src/either.dart';

class SignupRepository extends ISignupRepository {
  SignupRepository({
    required this.authRepository,
    required this.firestoreRepository,
    required this.storageRepository,
  });

  final IAuthRepository authRepository;
  final ICloudFirestoreRepository firestoreRepository;
  final IStorageRepository storageRepository;

  @override
  Future<Either<ApiError, String>> registerUserWithAuth(
      {required String email, required String password}) async {
    final response = await authRepository.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
    return response.fold(
      (ApiError l) => left(l),
      (String r) => right(r),
    );
  }

  @override
  Future<Either<ApiError, UserData>> uploadDataWithFirestore({
    required String collectionName,
    required String docId,
    required UserData userData,
  }) async {
    if (firebaseAuth.currentUser == null) {
      return left(
        ApiError(
          message: 'Not Authorized',
        ),
      );
    }
    final response = await firestoreRepository.uploadData(
      collectionName: FirestoreCollections.users,
      docId: docId,
      object: userData.toJson(),
    );
    return response.fold(
      (l) => left(l.toApiError()),
      (r) => right(
        userData,
      ),
    );
  }

  @override
  Future<Either<ApiError, String>> uploadUserProfilePic({
    required File file,
  }) async {
    if (firebaseAuth.currentUser == null) {
      return left(
        ApiError(
          message: 'Not Authorized',
        ),
      );
    }
    final userId = firebaseAuth.currentUser!.uid;
    final imageResponse = await storageRepository.uploadImage(
      path: 'users/$userId/profile_pic',
      file: file,
    );
    return imageResponse.fold((l) => left(l.toApiError()), (r) => right(r));
  }

  @override
  Future<Either<ApiError, UserSetting>> uploadUserSetting({
    required String docId,
    required UserSetting userSetting,
  }) async {
    if (firebaseAuth.currentUser == null) {
      return left(
        ApiError(
          message: 'Not Authorized',
        ),
      );
    }
    final response = await firestoreRepository.uploadNestedCollection(
      firstCollectionName: FirestoreCollections.users,
      firstDocId: docId,
      secondCollection2Name: FirestoreCollections.settings,
      secondDocId: docId,
      object: userSetting.toJson(),
    );
    return response.fold(
      (l) => left(
        l.toApiError(),
      ),
      (r) => right(
        userSetting,
      ),
    );
  }
}
