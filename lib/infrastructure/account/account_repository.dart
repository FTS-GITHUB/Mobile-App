// ignore_for_file: implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/account/i_account_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';

class AccountRepository implements IAccountRepository {
  AccountRepository({
    required this.firestoreRepository,
  });

  final ICloudFirestoreRepository firestoreRepository;

  @override
  Future<Either<ApiError, Unit>> updatePersonalInfo({
    required UserData userData,
  }) async {
    final user = getIt<UserService>().userData;
    if (user?.id == null) {
      return left(ApiError(message: '404 Not authorized.'));
    } else {
      final response = await firestoreRepository.updateDocument(
        collectionName: FirestoreCollections.users,
        docId: user!.id!,
        object: userData.toJson(),
      );
      return response.fold(
        (l) => left(
          l.toApiError(),
        ),
        (DocumentSnapshot<Map<String, dynamic>> r) {
          UserData updatedUserData = UserData.fromJson(
            r.data() ?? {},
          );
          getIt<UserService>().userData = updatedUserData;
          return right(unit);
        },
      );
    }
  }

  @override
  Future<Either<ApiError, Unit>> updateUserSetting({
    required String userId,
    required UserSetting userSetting,
  }) async {
    final response = await firestoreRepository.updateNestedDocument(
      firstCollectionName: FirestoreCollections.users,
      firstDocId: userId,
      secondCollectionName: FirestoreCollections.settings,
      secondDocId: userId,
      object: userSetting.toJson(),
    );
    return response.fold(
      (l) => left(
        l.toApiError(),
      ),
      (DocumentSnapshot<Map<String, dynamic>> r) {
        UserSetting updatedUserSetting = UserSetting.fromJson(
          r.data() ?? {},
        );
        getIt<UserService>().userSetting = updatedUserSetting;
        return right(unit);
      },
    );
  }
}
