import 'dart:async';

import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/domain/session/session.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/presentation/analytics/analytics_page.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc({
    required this.sessionRepository,
  }) : super(AnalyticsStateInitial()) {
    on<FetchAnalytics>(_onFetchAnalytics);
  }

  final ISessionRepository sessionRepository;

  Future<void> _onFetchAnalytics(
      FetchAnalytics event, Emitter<AnalyticsState> emit) async {
    final user = getIt<UserService>().userData;
    if (user?.id == null) {
      emit(AnalyticsStateError(message: 'Not authorized'));
    } else {
      emit(AnalyticsStateLoading());
      final response = await sessionRepository.getSessions(
        userId: user!.id!,
        type: event.type!,
      );
      response.fold(
        (l) => emit(
            AnalyticsStateError(message: l.message ?? 'Failed to connect')),
        (List<Session> r) {
          List<SplineAreaData> chartData = [];
          List<SplineAreaData> tempChartData = [];
          double totalTimeInMinutes = 0;
          r.forEach((data) {
            print(data.appUseDuration);
            Duration sessionDuration = parseDuration(data.appUseDuration!);
            double durationInMinutes = sessionDuration.inMinutes.toDouble();
            print(durationInMinutes);
            chartData.add(
              SplineAreaData(
                DateTime.fromMillisecondsSinceEpoch(data.sessionDate!),
                durationInMinutes,
              ),
            );
            tempChartData.add(
              SplineAreaData(
                DateTime.fromMillisecondsSinceEpoch(data.sessionDate!),
                durationInMinutes,
              ),
            );
          });
          if (chartData.isNotEmpty) {
            tempChartData.sort((a, b) => a.y1.compareTo(b.y1));
            tempChartData.forEach((element) {
              totalTimeInMinutes = totalTimeInMinutes + element.y1;
              print("Day of Week: ${element.year.weekday}");
            });
            print(
              "Maximum minutes in chart list is: ${tempChartData.last.y1}"
            );
            // chartData.sort((a,b)=> b.year.compareTo(a.year));
          }
          emit(
            AnalyticsStateLoaded(
              chartData: chartData,
              currentStreak: 0,
              longestStreak: 0,
              sessionsListened: 0,
              maxMinutes: tempChartData.last.y1,
              totalTimeInMinutes: totalTimeInMinutes,
            ),
          );
        },
      );
    }
  }
}
