part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchDownloads extends DownloadEvent{
  FetchDownloads();

}
