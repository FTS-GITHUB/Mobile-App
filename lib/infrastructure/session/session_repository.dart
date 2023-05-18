import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';

class SessionRepository implements ISessionRepository {
  SessionRepository({required this.firestoreRepository});

  final ICloudFirestoreRepository firestoreRepository;

  @override
  Future<Either<ApiError, Unit>> uploadSession({
    required String userId,
    required Session session,
  }) async {
    final response = await firestoreRepository.uploadSessionDocument(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.sessions,
      firstDocId: userId,
      object: session.toJson(),
    );
    return response.fold(
      (l) => left(l.toApiError()),
      (r) => right(unit),
    );
  }

  @override
  Future<Either<ApiError, List<Session>>> getSessions({
    required String userId,
    required String type,
  }) async {
    final response = await firestoreRepository.getSessionCollection(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.sessions,
      docId: userId,
      type: type,
    );
    return response.fold(
          (l) => left(l.toApiError()),
          (QuerySnapshot<Map<String, dynamic>> r){
            List<Session> sessions = [];
            for(var docSnapshot in r.docs){
              Session newSession = Session.fromJson(docSnapshot.id, docSnapshot.data());
              sessions.add(newSession);
            }
            return right(sessions);
          },
    );
  }
}
