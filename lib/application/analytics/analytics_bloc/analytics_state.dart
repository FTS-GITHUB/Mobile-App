part of 'analytics_bloc.dart';

abstract class AnalyticsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnalyticsStateInitial extends AnalyticsState {}

class AnalyticsStateLoading extends AnalyticsState {}

class AnalyticsStateLoaded extends AnalyticsState {
  AnalyticsStateLoaded({
    required this.chartData,
    required this.currentStreak,
    required this.longestStreak,
    required this.sessionsListened,
    required this.maxMinutes,
    required this.totalTimeInMinutes,
    // required this.packsListened,
  });

  final List<SplineAreaData> chartData;
  final int? currentStreak;
  final int? longestStreak;
  final int? sessionsListened;
  final double? maxMinutes;
  final double? totalTimeInMinutes;
  // final int? packsListened;
}

class AnalyticsStateError extends AnalyticsState {
  AnalyticsStateError({
    required this.message,
  });

  final String message;
}
