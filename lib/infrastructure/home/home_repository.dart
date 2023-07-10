// ignore_for_file: implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:dropandgouser/domain/search/previous_searches.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/firestore_collections.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
      searches.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return right(searches);
    });
  }

  @override
  Future<Either<ApiError, Unit>> uploadNewSearch({
    required String userId,
    required String searchText,
  }) async {
    final response = await cloudFirestoreRepository.uploadNestedSearchCollection(
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
  }) async {
    final response =
        await cloudFirestoreRepository.deleteSpecificNestedDocument(
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

  @override
  Future<Either<ApiError, List<Audio>>> getAudios({
    required String categoryId,
  }) async {
    final response = await cloudFirestoreRepository.getCollection(
      collectionName: FirestoreCollections.audios,
      whereKey: 'category.id',
      whereValue: categoryId,
    );
    return response.fold(
      (l) => left(l.toApiError()),
      (r) {
        List<Audio> audios = <Audio>[];
        for (var docSnapshot in r.docs) {
          Audio audio = Audio.fromJson(
            docSnapshot.id,
            docSnapshot.data(),
          );
          audios.add(audio);
        }
        return right(audios);
      },
    );
  }

  @override
  Future<Either<ApiError, Category>> getCategory(
      {required String categoryId}) async {
    final response = await cloudFirestoreRepository.getDocument(
      collectionName: FirestoreCollections.categories,
      docId: categoryId,
    );
    return response.fold(
      (l) => left(l.toApiError()),
      (r) {
        Category category = Category.fromJson(
          r.id,
          r.data() ?? {},
        );
        return right(category);
      },
    );
  }

  @override
  Future<Either<ApiError, UserData>> likeCategory({
    required String userId,
    required String categoryId,
  }) async {
    UserData userData = UserData();
    final response = await cloudFirestoreRepository.getDocument(
      collectionName: FirestoreCollections.users,
      docId: userId,
    );
    return response.fold((l) => left(l.toApiError()), (r) async {
      userData = UserData.fromJson(r.data() ?? {});
      if (userData.likedCategories == null ||
          userData.likedCategories!.isEmpty ||
          !(userData.likedCategories!.contains(categoryId))) {
        userData.likedCategories?.add(categoryId);
        final response = await cloudFirestoreRepository.updateDocument(
          collectionName: FirestoreCollections.users,
          docId: userId,
          object: userData.toJson(),
        );
        return response.fold(
          (l) => left(l.toApiError()),
          (docSnapshot) {
            userData = UserData.fromJson(
              docSnapshot.data() ?? {},
            );
            return right(userData);
          },
        );
      } else {
        userData.likedCategories!.remove(categoryId);
        final response = await cloudFirestoreRepository.updateDocument(
          collectionName: FirestoreCollections.users,
          docId: userId,
          object: userData.toJson(),
        );
        return response.fold(
          (l) => left(l.toApiError()),
          (docSnapshot) {
            userData = UserData.fromJson(
              docSnapshot.data() ?? {},
            );
            return right(userData);
          },
        );
      }
    });
  }

  @override
  Future<Either<ApiError, List<Audio>>> getDownloads() async {
    List<Audio> audios = [];
    final user = getIt<UserService>().userData;
    if (user?.id == null) {
      return left(
        ApiError(
          message: 'Not authorized, login again',
        ),
      );
    }
    final Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>
        response = await cloudFirestoreRepository.getNestedCollection(
            firstCollectionName: FirestoreCollections.users,
            secondCollectionName: FirestoreCollections.downloads,
            docId: user!.id!);
    return response.fold((l) => left(l.toApiError()), (docsSnapshot) {
      docsSnapshot.docs.forEach((doc) {
        Audio audio = Audio.fromJson(doc.id, doc.data());
        audios.add(audio);
      });
      return right(audios);
    });
  }

  @override
  Future<Either<ApiError, Unit>> deleteDownloadedAudio(
      {required String userId, required String docId}) async {
    final response =
        await cloudFirestoreRepository.deleteSpecificNestedDocument(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.downloads,
      firstDocId: userId,
      secondDocId: docId,
    );
    return response.fold(
      (l) => left(l.toApiError()),
      (r) => right(r),
    );
  }

  @override
  Future<Either<ApiError, Unit>> addDownload({
    required String userId,
    required Audio audio,
  }) async{
    final response = await cloudFirestoreRepository.uploadNestedCollection(
      firstCollectionName: FirestoreCollections.users,
      secondCollectionName: FirestoreCollections.downloads,
      firstDocId: userId,
      object: audio.toJson(),
    );
    return response.fold(
          (l) => left(l.toApiError()),
          (r) => right(r),
    );
  }
}
