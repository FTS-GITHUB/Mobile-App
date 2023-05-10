// ignore_for_file: implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/search/previous_searches.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';

class HomeRepository implements IHomeRepository {
  HomeRepository({
    required this.cloudFirestoreRepository,
  });

  final ICloudFirestoreRepository cloudFirestoreRepository;

  @override
  Future<Either<ApiError, List<Category>>> getCategories() async {
    List<Category> categories = [];
    final response = await cloudFirestoreRepository.getCollection(
      collectionName: FirestoreCollections.categories,
    );
    return response.fold(
        (l) => left(
              l.toApiError(),
            ), (
      QuerySnapshot<Map<String, dynamic>> querySnapshot,
    ) {
      for (var documentSnapshot in querySnapshot.docs) {
        Category category = Category.fromJson(
          documentSnapshot.id,
          documentSnapshot.data(),
        );
        categories.add(category);
      }
      return right(categories);
    });
  }

  @override
  Future<Either<ApiError, List<PreviousSearches>>> getPreviousSearches({
    required String userId,
  }) async {
    List<PreviousSearches> searches = [];
    final response = await cloudFirestoreRepository.getNestedCollection(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.search,
      docId: userId,
    );
    return response.fold(
        (l) => left(
              l.toApiError(),
            ), (
      QuerySnapshot<Map<String, dynamic>> querySnapshot,
    ) {
      for (var documentSnapshot in querySnapshot.docs) {
        PreviousSearches search = PreviousSearches.fromJson(
          documentSnapshot.id,
          documentSnapshot.data(),
        );
        searches.add(search);
      }
      return right(searches);
    });
  }

  @override
  Future<Either<ApiError, Unit>> uploadNewSearch({
    required String userId,
    required String searchText,
  }) async {
    final response = await cloudFirestoreRepository.uploadNestedCollection(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.search,
      firstDocId: userId,
      object: searchText,
    );
    return response.fold(
      (l) => left(l.toApiError()),
      (r) => right(r),
    );
  }

  @override
  Future<Either<ApiError, Unit>> deleteSearch({
    required String userId,
    required String docId,
  }) async{
    final response = await cloudFirestoreRepository.deleteSpecificNestedDocument(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.search,
      firstDocId: userId,
      secondDocId: docId,
    );
    return response.fold(
          (l) => left(l.toApiError()),
          (r) => right(r),
    );
  }
}
