import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class ISessionRepository {
  Future<Either<ApiError, Unit>> uploadSession({
    required String userId,
    required Session session,
  });

  Future<Either<ApiError, List<Session>>> getSessions({
    required String userId,
    required String type,
  });

  Future<Either<ApiError, Unit>> uploadSessionRating({
    required String userId,
    required double rating,
    required String sessionId,
  });

  Future<Either<ApiError, List<Session>>> getAllSessions({
    required String userId,
  });

  Future<Either<ApiError, UserData>> updateUserData({
    required String userId,
    required UserData userData,
  });
}
