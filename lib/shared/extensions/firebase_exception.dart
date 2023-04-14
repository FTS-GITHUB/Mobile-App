import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseExceptionX on FirebaseException {
  ApiError toApiError() {
    ApiError apiError = ApiError();
    apiError = apiError.copyWith(
      code: code,
      message: message,
    );
    return apiError;
  }
}


extension FirebaseAuthExceptionX on FirebaseAuthException {
  ApiError toApiAuthError() {
    ApiError apiError = ApiError();
    apiError =apiError.copyWith(
      code: code,
      message: message,
    );
    return apiError;
  }
}

