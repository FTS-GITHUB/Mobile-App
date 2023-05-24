part of 'all_session_bloc.dart';

abstract class AllSessionEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchSessions extends AllSessionEvent{}

class UpdateSessions extends AllSessionEvent{
  UpdateSessions({
    required this.sessionDates,
    required this.userId,
});
  final List<DateTime> sessionDates;
  final String userId;
}