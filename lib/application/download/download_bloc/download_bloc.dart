import 'dart:async';

import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'download_event.dart';

part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc()
      : super(
          DownloadStateInitial(),
        ){
    on<FetchDownloads>(_onFetchDownloads);
    on<DownloadAudio>(_onDownloadAudio);
  }


  FutureOr<void> _onFetchDownloads(FetchDownloads event, Emitter<DownloadState> emit) async{
  }

  Future<void> _onDownloadAudio(DownloadAudio event, Emitter<DownloadState> emit) async{

  }
}
