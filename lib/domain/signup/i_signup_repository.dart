import 'dart:io';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class ISignupRepository {
  Future<Either<ApiError, Unit>> registerUserWithAuth({
    required String email,
    required String password,
  });

  Future<Either<ApiError, UserData>> uploadDataWithFirestore({
    required String collectionName,
    required String docId,
    required dynamic object,
  });

  Future<Either<ApiError, String>> uploadUserProfilePic({
    required String path,
    required File file,
  });


}