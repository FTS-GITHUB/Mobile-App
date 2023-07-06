part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloadStateInitial extends DownloadState {}

class DownloadStateLoading extends DownloadState {}

class DownloadStateLoaded extends DownloadState {
  DownloadStateLoaded({
    required this.audios,
});

  final List<Audio> audios;
}

class DownloadStateAdded extends DownloadState {
  DownloadStateAdded();
}

class DownloadStateDeleted extends DownloadState {
  DownloadStateDeleted();
}

class DownloadStateError extends DownloadState {
  DownloadStateError({
    required this.message,
  });

  final String message;
}
