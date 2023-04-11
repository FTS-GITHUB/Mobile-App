import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/common/setting.dart';
import 'package:dropandgouser/domain/i_setting_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/src/either.dart';

class SettingRepository extends ISettingRepository {
  SettingRepository({
    required this.firestoreRepository,
  });

  final ICloudFirestoreRepository firestoreRepository;

  @override
  Future<Either<ApiError, DropAndGoSetting?>> getAchievementSettings() async {
    final Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>
        response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.settings,
      docId: FirestoreDocuments.achievement,
    );
    return response.fold(
      (FirebaseException l) => left(l.toApiError()),
      (r) => right(
        DropAndGoSetting.fromJson(r.id, r.data() ?? {}),
      ),
    );
  }

  @override
  Future<Either<ApiError, DropAndGoSetting?>> getAgeSettings() async{
    final Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>
    response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.settings,
      docId: FirestoreDocuments.age,
    );
    return response.fold(
          (FirebaseException l) => left(l.toApiError()),
          (r) => right(
        DropAndGoSetting.fromJson(r.id, r.data() ?? {}),
      ),
    );
  }

  @override
  Future<Either<ApiError, DropAndGoSetting?>> getCompleteProfileSettings() async{
    final Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>
    response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.settings,
      docId: FirestoreDocuments.completeProfile,
    );
    return response.fold(
          (FirebaseException l) => left(l.toApiError()),
          (r) => right(
        DropAndGoSetting.fromJson(r.id, r.data() ?? {}),
      ),
    );
  }

  @override
  Future<Either<ApiError, DropAndGoSetting?>> getCreteAccountSettings() async{
    final Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>
    response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.settings,
      docId: FirestoreDocuments.createAccount,
    );
    return response.fold(
          (FirebaseException l) => left(l.toApiError()),
          (r) => right(
        DropAndGoSetting.fromJson(r.id, r.data() ?? {}),
      ),
    );
  }

  @override
  Future<Either<ApiError, DropAndGoSetting?>> getGenderSettings() async{
    final Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>
    response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.settings,
      docId: FirestoreDocuments.gender,
    );
    return response.fold(
          (FirebaseException l) => left(l.toApiError()),
          (r) => right(
        DropAndGoSetting.fromJson(r.id, r.data() ?? {}),
      ),
    );
  }

  @override
  Future<Either<ApiError, DropAndGoSetting?>> getRecommendationSettings() async{
    final Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>
    response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.settings,
      docId: FirestoreDocuments.recommendation,
    );
    return response.fold(
          (FirebaseException l) => left(l.toApiError()),
          (r) => right(
        DropAndGoSetting.fromJson(r.id, r.data() ?? {}),
      ),
    );
  }

  @override
  Future<Either<ApiError, DropAndGoSetting?>> getSignupSuccessSettings() async{
    final Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>
    response = await firestoreRepository.getDocument(
      collectionName: FirestoreCollections.settings,
      docId: FirestoreDocuments.signupSuccess,
    );
    return response.fold(
          (FirebaseException l) => left(l.toApiError()),
          (r) => right(
        DropAndGoSetting.fromJson(r.id, r.data() ?? {}),
      ),
    );
  }
}
