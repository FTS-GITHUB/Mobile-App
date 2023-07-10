part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchDownloads extends DownloadEvent{
  FetchDownloads();
}

class DeleteDownload extends DownloadEvent{
  DeleteDownload({
    required this.downloadId,
});

  final String downloadId;
}

class AddDownload extends DownloadEvent{
  AddDownload({
    required this.audio,
});

  final Audio audio;
}
