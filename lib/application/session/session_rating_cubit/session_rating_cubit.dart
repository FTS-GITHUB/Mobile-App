import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_rating_state.dart';

class SessionRatingCubit extends Cubit<SessionRatingState> {
  SessionRatingCubit({
    required this.sessionRepository,
  }) : super(SessionRatingStateInitial());

  final ISessionRepository sessionRepository;

  uploadSessionRating({
    required double rating,
    required String sessionId,
  }) async {
    final userData = getIt<UserService>().userData;
    if (userData?.id == null) {
      emit(
        SessionRatingStateError(
          message: "You are not authorized",
        ),
      );
    } else {
      emit(SessionRatingStateUploading());
      final response = await sessionRepository.uploadSessionRating(
        userId: userData!.id!,
        rating: rating,
        sessionId: sessionId,
      );
      response.fold(
        (l) => emit(
          SessionRatingStateError(
            message: l.message ?? 'Failed to connect',
          ),
        ),
        (r) => emit(
          SessionRatingStateUploaded(),
        ),
      );
    }
  }
}
