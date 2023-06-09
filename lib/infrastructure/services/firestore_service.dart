// ignore_for_file: implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICloudFirestoreRepository)
class FirestoreService implements ICloudFirestoreRepository {
  FirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<Either<FirebaseException, Unit>> uploadData({
    required String collectionName,
    required String docId,
    required dynamic object,
  }) async {
    try {
      await _firestore.collection(collectionName).doc(docId).set(object);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentReference>> uploadDocument({
    required String collectionName,
    required dynamic object,
  }) async {
    try {
      DocumentReference docRef =
          await _firestore.collection(collectionName).add(object);
      return right(docRef);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getCollection({
    required String collectionName,
    Object? whereKey,
    Object? whereValue,
  }) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> documentSnapshot;
      if (whereKey != null) {
        await _firestore
            .collection(collectionName)
            .where(whereKey, isEqualTo: whereValue)
            .get()
            .then(
              (QuerySnapshot<Map<String, dynamic>> value) =>
                  documentSnapshot = value,
            );
      } else {
        await _firestore.collection(collectionName).get().then(
              (QuerySnapshot<Map<String, dynamic>> value) =>
                  documentSnapshot = value,
            );
      }
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getDocument(
          {required String collectionName, required String docId}) async {
    try {
      late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
      await _firestore.collection(collectionName).doc(docId).get().then(
            (DocumentSnapshot<Map<String, dynamic>> value) =>
                documentSnapshot = value,
          );
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      updateDocument(
          {required String collectionName,
          required String docId,
          required object}) async {
    try {
      await _firestore.collection(collectionName).doc(docId).set(
            object,
            SetOptions(merge: true),
          );
      final response =
          await _firestore.collection(collectionName).doc(docId).get();
      return right(response);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> uploadNestedSearchCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    String? secondDocId,
    required object,
  }) async {
    try {
      if (secondDocId != null) {
        await _firestore
            .collection(firstCollectionName)
            .doc(firstDocId)
            .collection(secondCollectionName)
            .doc(secondDocId)
            .set(object);
      } else {
        final docRef = _firestore
            .collection(firstCollectionName)
            .doc(firstDocId)
            .collection(secondCollectionName)
            .doc();
        await _firestore
            .collection(firstCollectionName)
            .doc(firstDocId)
            .collection(secondCollectionName)
            .doc(docRef.id)
            .set({
          'id': docRef.id,
          'name': object,
          'created_at': DateTime.now(),
        });
      }
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> uploadNestedCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    String? secondDocId,
    required object,
  }) async {
    try {
      final docRef = _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .doc();
      await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .doc(docRef.id)
          .set(object);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getNestedDocument(
          {required String firstCollectionName,
          required String secondCollectionName,
          required String docId}) async {
    try {
      final response = await _firestore
          .collection(firstCollectionName)
          .doc(docId)
          .collection(secondCollectionName)
          .doc(docId)
          .get();
      return right(response);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getNestedCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String docId,
  }) async {
    try {
      final response = await _firestore
          .collection(firstCollectionName)
          .doc(docId)
          .collection(secondCollectionName)
          .orderBy('created_at', descending: true)
          .get();
      return right(response);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> deleteSpecificNestedDocument({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    required String secondDocId,
  }) async {
    try {
      await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .doc(secondDocId)
          .delete();
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      updateNestedDocument({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    required String secondDocId,
    required object,
  }) async {
    try {
      await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .doc(secondDocId)
          .set(
            object,
            SetOptions(
              merge: true,
            ),
          );
      final response = await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .doc(secondDocId)
          .get();
      return right(response);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> uploadSessionDocument({
    required String firstCollectionName,
    required String secondCollectionName,
    required String firstDocId,
    String? secondDocId,
    required object,
  }) async {
    try {
      await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .doc(secondDocId)
          .set(object, SetOptions(merge: true));
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getSessionCollection({
    required String firstCollectionName,
    required String secondCollectionName,
    required String docId,
    required String type,
  }) async {
    try {
      late final QuerySnapshot<Map<String, dynamic>> response;
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime sevenDaysAgo = DateTime(now.year, now.month, now.day - 7);
      DateTime monthAgo = DateTime(now.year, now.month - 1, now.day);
      print(sevenDaysAgo.millisecondsSinceEpoch);
      print(today.millisecondsSinceEpoch);
      if (type == 'week') {
        response = await _firestore
            .collection(firstCollectionName)
            .doc(docId)
            .collection(secondCollectionName)
            .where(
              'session_date',
              isGreaterThanOrEqualTo: sevenDaysAgo.millisecondsSinceEpoch,
              isLessThanOrEqualTo: today.millisecondsSinceEpoch,
            )
            .orderBy('session_date', descending: false)
            .get();
      } else {
        response = await _firestore
            .collection(firstCollectionName)
            .doc(docId)
            .collection(secondCollectionName)
            .where(
              'session_date',
              isGreaterThanOrEqualTo: dateToJson(monthAgo),
              isLessThanOrEqualTo: dateToJson(today),
            )
            .get();
      }
      return right(response);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getComplexCollection({
    required String collectionName,
    Object? whereKey,
    dynamic object,
  }) async{
    try {
      late QuerySnapshot<Map<String, dynamic>> documentSnapshot;
      if (whereKey != null) {
        await _firestore
            .collection(collectionName)
            .where(whereKey, arrayContains: object)
            .get()
            .then(
              (QuerySnapshot<Map<String, dynamic>> value) =>
          documentSnapshot = value,
        );
      } else {
        await _firestore.collection(collectionName).get().then(
              (QuerySnapshot<Map<String, dynamic>> value) =>
          documentSnapshot = value,
        );
      }
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }
}
