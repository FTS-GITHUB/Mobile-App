import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

class SplashRepository {
  SplashRepository(this.cloudFirestoreRepository);

  final ICloudFirestoreRepository cloudFirestoreRepository;

  Future<Either<ApiError, UserData>> getUser({
    required String userid,
  }) async {
    final response = await cloudFirestoreRepository.getDocument(
      collectionName: FirestoreCollections.users,
      docId: userid,
    );
    return response.fold(
            (l) => left(l.toApiError()),
            (r) => right(
          UserData.fromJson(r.data() ?? {}),
        ));
  }

  Future<Either<ApiError, UserSetting>> getUserSettings({
    required String userid,
  }) async {
    final response = await cloudFirestoreRepository.getNestedDocument(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.settings,
      docId: userid,
    );
    return response.fold(
        (l) => left(l.toApiError()),
        (r) => right(
              UserSetting.fromJson(r.data() ?? {}),
            ));
  }
}
