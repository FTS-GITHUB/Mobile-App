// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:dropandgouser/domain/services/i_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IStorageRepository)
class FirebaseStorageRepository implements IStorageRepository {
  FirebaseStorageRepository(this._firebaseStorage);
  final FirebaseStorage _firebaseStorage;

  @override
  Future<Either<FirebaseException, String>> uploadImage({
    required String path,
    required File file,
  }) async {
    try{
      late String imageUrl;
      await _firebaseStorage
          .refFromURL('gs://dropandgo-c32c9.appspot.com')
          .child(path)
          .putFile(file)
          .then((TaskSnapshot val) async{
        imageUrl = await val.ref.getDownloadURL();
      });
      return right(imageUrl);
    }on FirebaseException catch(e){
      return left(e);
    }

  }
}
