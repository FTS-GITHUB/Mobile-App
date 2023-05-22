part of 'download_bloc.dart';

abstract class AnalyticsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DownloadAudio extends AnalyticsEvent{
  DownloadAudio();
}
