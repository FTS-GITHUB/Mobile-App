import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract class IStorageRepository{
  Future<Either<FirebaseException, String>> uploadImage({
    required String path,
    required File file,
});
}