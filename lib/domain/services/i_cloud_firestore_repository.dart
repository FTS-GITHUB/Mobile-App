import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICloudFirestoreRepository{
  Future<Either<FirebaseException, Unit>> uploadData({
    required String collectionName,
    required String docId,
    required dynamic object,
  });


  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>> updateDocument({
    required String collectionName,
    required String docId,
    required dynamic object,
  });

  Future<Either<FirebaseException, DocumentReference>> uploadDocument({
    required String collectionName,
    required dynamic object,
  });

  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>> getCollection({
    required String collectionName,
    Object? whereKey,
    Object? whereValue,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>> getDocument({
    required String collectionName,
    required String docId,
  });


}