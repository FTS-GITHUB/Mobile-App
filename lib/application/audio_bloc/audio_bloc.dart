import 'dart:async';

import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc({
    required this.homeRepository,
  }) : super(AudioStateInitial()) {
    on<FetchAudios>(_onFetchAudios);
    on<FetchCategory>(_onFetchCategory);
  }

  final IHomeRepository homeRepository;

  Future<void> _onFetchAudios(
      FetchAudios event, Emitter<AudioState> emit) async {
    emit(AudioStateLoading());
    final response = await homeRepository.getAudios(
      categoryId: event.categoryId,
    );

    response.fold(
      (l) => emit(AudioStateError(message: l.message ?? 'Failed to connect')),
      (r) => add(
        FetchCategory(
          categoryId: event.categoryId,
          audios: r,
        ),
      ),
    );
  }

  Future<void> _onFetchCategory(
      FetchCategory event, Emitter<AudioState> emit) async {
    final response =
        await homeRepository.getCategory(categoryId: event.categoryId);
    response.fold(
      (l) => emit(AudioStateError(message: l.message ?? 'Failed to connect')),
      (r) => emit(
        AudioStateLoaded(
          audios: event.audios,
          category: r,
        ),
      ),
    );
  }
}
