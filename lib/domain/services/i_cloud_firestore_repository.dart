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

  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>> getComplexCollection({
    required String collectionName,
    Object? whereKey,
    dynamic object,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>> getDocument({
    required String collectionName,
    required String docId,
  });

  Future<Either<FirebaseException, Unit>> uploadNestedSearchCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    String? secondDocId,
    required dynamic object,
  });

  Future<Either<FirebaseException, Unit>> uploadNestedCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    String? secondDocId,
    required dynamic object,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>> getNestedDocument({
    required String firstCollectionName,
    required String secondCollectionName,
    required String docId,
  });

  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>> getNestedCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String docId,
  });

  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>> getSessionCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String docId,
    required String type,
  });

  Future<Either<FirebaseException, Unit>> deleteSpecificNestedDocument({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    required String secondDocId,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>> updateNestedDocument({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    required String secondDocId,
    required dynamic object,
  });

  Future<Either<FirebaseException, Unit>> uploadSessionDocument({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    String? secondDocId,
    required object,
  });
}