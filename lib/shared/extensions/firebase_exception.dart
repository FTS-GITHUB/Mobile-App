import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';

extension FirebaseExceptionX on FirebaseException {
  ApiError toApiError() {
    final apiError = ApiError();
    apiError.copyWith(
      code: code,
      message: message,
    );
    return ApiError();
  }
}
