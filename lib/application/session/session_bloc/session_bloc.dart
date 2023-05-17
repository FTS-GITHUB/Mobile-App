import 'dart:async';

import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.sessionRepository,
  }) : super(SessionStateInitial()) {
    on<UploadSession>(_onUploadSession);
  }

  final ISessionRepository sessionRepository;

  Future<void> _onUploadSession(
      UploadSession event, Emitter<SessionState> emit) async {
    emit(SessionStateUploading());
    final response = await sessionRepository.uploadSession(
      userId: event.userId,
      session: event.session,
    );
    response.fold(
      (l) => emit(SessionStateError(
          message: l.message ?? "Couldn't connect, please try again")),
      (r) => emit(
        SessionStateUploaded(),
      ),
    );
  }
}
