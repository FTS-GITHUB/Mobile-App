import 'dart:async';

import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'download_event.dart';

part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc({
    required this.homeRepository,
  }) : super(
          DownloadStateInitial(),
        ) {
    on<FetchDownloads>(_onFetchDownloads);
    on<DeleteDownload>(_onDeleteDownload);
    on<AddDownload>(_onAddDownload);
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
        if (r.isNotEmpty) {
          r.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        }
        emit(
          DownloadStateLoaded(audios: r),
        );
      },
    );
  }

  Future<void> _onDeleteDownload(
      DeleteDownload event, Emitter<DownloadState> emit) async {
    final user = getIt<UserService>().userData;
    if (user?.id == null) {
      emit(
        DownloadStateError(
          message: "Not authorized",
        ),
      );
    }else{
      final response = await homeRepository.deleteDownloadedAudio(
        userId: user?.id ?? '',
        docId: event.downloadId,
      );
      response.fold(
            (l) => emit(
          DownloadStateError(
            message: l.message ?? "Failed to get data",
          ),
        ),
            (r) => add(FetchDownloads()),
      );
    }
  }

  Future<void> _onAddDownload(
      AddDownload event, Emitter<DownloadState> emit) async {
    final user = getIt<UserService>().userData;
    if (user?.id == null) {
      emit(
        DownloadStateError(
          message: "Not authorized",
        ),
      );
    }else{
      final response = await homeRepository.addDownload(
        userId: user?.id ?? '',
        audio: event.audio,
      );
      response.fold(
            (l) => emit(
          DownloadStateError(
            message: l.message ?? "Failed to get data",
          ),
        ),
            (r) => emit(DownloadStateAdded()),
      );
    }
  }
}
