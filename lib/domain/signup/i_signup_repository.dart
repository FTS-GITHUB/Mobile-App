import 'dart:io';

import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class ISignupRepository {
  Future<Either<ApiError, String>> registerUserWithAuth({
    required String email,
    required String password,
  });

  Future<Either<ApiError, UserData>> uploadDataWithFirestore({
    required String collectionName,
    required String docId,
    required UserData userData,
  });

  Future<Either<ApiError, String>> uploadUserProfilePic({
    required File file,
  });


}