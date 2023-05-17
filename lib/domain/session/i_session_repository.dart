import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class ISessionRepository {
  Future<Either<ApiError, Unit>> uploadSession({
    required String userId,
    required Session session,
  });
}
