part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchAnalytics extends AnalyticsEvent{
  FetchAnalytics({this.type='week'});
  final String? type;
}