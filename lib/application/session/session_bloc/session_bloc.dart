import 'dart:async';

import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/infrastructure/services/local_database_service.dart';
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
    on<DeletePreviousSession>(_onDeletePreviousSession);
  }

  final ISessionRepository sessionRepository;

  Future<void> _onUploadSession(UploadSession event,
      Emitter<SessionState> emit) async {
    emit(SessionStateUploading());
    final response = await sessionRepository.uploadSession(
      userId: event.userId,
      session: event.session,
    );
    response.fold(
            (l) =>
            emit(SessionStateError(
                message: l.message ?? "Couldn't connect, please try again")),
            (r) =>
            add(
              DeletePreviousSession(
                userId: event.userId,
                session: event.session,
              ),
            ));
  }

  Future<void> _onGetAllSessions(GetAllSessions event,
      Emitter<SessionState> emit) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    localDatabaseService = LocalDatabaseService();
    List<Session> sessions = await localDatabaseService!.getSessionsList();
    sessions.forEach((element) {
      print(element.toJson());
    });
    sessions = sessions
        .where((session) => session.sessionDate != today.millisecondsSinceEpoch)
        .toList();
    if (sessions.isNotEmpty) {
      add(
        UploadSession(
          userId: event.userId,
          session: Session(
            id: sessions.last.id,
            sessionDate: sessions.last.sessionDate,
            appUseDuration: sessions.last.appUseDuration,
            isSessionCompleted: sessions.last.isSessionCompleted,
          ),
        ),
      );
    } else {
      emit(SessionStateUploaded());
    }
  }

  Future<void> _onDeletePreviousSession(DeletePreviousSession event,
      Emitter<SessionState> emit) async {
    deletePreviousSession(event.session.id!);
    add(
      GetAllSessions(
        userId: event.userId,
      ),
    );
  }
}
