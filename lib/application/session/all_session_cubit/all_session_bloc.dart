import 'dart:async';

import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_session_state.dart';

part 'all_session_event.dart';

class AllSessionBloc extends Bloc<AllSessionEvent, AllSessionState> {
  AllSessionBloc({
    required this.sessionRepository,
  }) : super(AllSessionStateInitial()) {
    on<FetchSessions>(_onFetchSessions);
    on<UpdateSessions>(_onUpdateSession);
  }

  final ISessionRepository sessionRepository;

  Future<void> _onFetchSessions(
      FetchSessions event, Emitter<AllSessionState> emit) async {
    final userData = getIt<UserService>().userData;
    if (userData?.id == null) {
      emit(
        AllSessionStateError(
          message: "You are not authorized",
        ),
      );
    } else {
      emit(AllSessionStateLoading());
      final response = await sessionRepository.getAllSessions(
        userId: userData!.id!,
      );
      response.fold(
          (l) => emit(
                AllSessionStateError(
                  message: l.message ?? 'Failed to connect',
                ),
              ), (List<Session> sessions) {
        List<DateTime> sessionDates = [];
        for (var session in sessions) {
          if (session.sessionDate != null) {
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch(session.sessionDate!);
            sessionDates.add(date);
          }
        }
        add(
          UpdateSessions(
            sessionDates: sessionDates,
            userId: userData.id!,
          ),
        );
      });
    }
  }

  Future<void> _onUpdateSession(
      UpdateSessions event, Emitter<AllSessionState> emit) async {
    int currentStreak = countCurrentStreak(event.sessionDates);
    int longestStreak = countLongestStreak(event.sessionDates);
    print("current streak is: $currentStreak");
    print("Longest streak is: $longestStreak");
    print("Total sessions: ${event.sessionDates}");
    emit(AllSessionStateLoaded());
    UserData? userData = getIt<UserService>().userData;
    if (userData?.longestStreak != null &&
        userData!.longestStreak! <= longestStreak) {
      userData = userData.copyWith(
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        sessionsListened: event.sessionDates.length,
      );
    } else {
      userData = userData?.copyWith(
        currentStreak: currentStreak,
      );
    }
    final response = await sessionRepository.updateUserData(
      userId: event.userId,
      userData: userData!,
    );
    response.fold(
        (l) => emit(
              AllSessionStateError(
                message: l.message ?? 'failed to connect',
              ),
            ), (r) {
      getIt<UserService>().userData = r;
      emit(AllSessionStateLoaded());
    });
  }
}
