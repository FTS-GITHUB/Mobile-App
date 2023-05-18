import 'dart:async';

import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.sessionRepository,
  }) : super(SessionStateInitial()) {
    on<UploadSession>(_onUploadSession);
    on<GetAllSessions>(_onGetAllSessions);
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

  Future<void> _onGetAllSessions(GetAllSessions event, Emitter<SessionState> emit) async{
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day-1);
    List<Session> sessions = await localDatabaseService.getSessionsList();
    sessions = sessions.where((session) => session.sessionDate== yesterday).toList();
    if(sessions.isNotEmpty){
      UploadSession(
        userId: event.userId,
        session: sessions.last
      );
    }
  }
}
