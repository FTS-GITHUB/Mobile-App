import 'dart:async';

import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

part 'download_event.dart';

part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc({
    required this.homeRepository,
  }) : super(
          DownloadStateInitial(),
        ) {
    on<FetchDownloads>(_onFetchDownloads);
  }

  final IHomeRepository homeRepository;

  FutureOr<void> _onFetchDownloads(
      FetchDownloads event, Emitter<DownloadState> emit) async {
    emit(DownloadStateLoading());
    final response = await homeRepository.getDownloads();
    response.fold(
      (l) => emit(
        DownloadStateError(
          message: l.message ?? "Failed to get data",
        ),
      ),
      (r) {
        if(r.isNotEmpty){
          r.sort((a, b)=> b.createdAt!.compareTo(a.createdAt!));
        }
        emit(
        DownloadStateLoaded(audios: r),
      );
      },
    );
  }
}
