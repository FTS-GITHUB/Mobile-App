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
    if (event.category == null) {
      add(FetchCategory(
        categoryId: event.categoryId,
      ));
    } else {
      final response = await homeRepository.getAudios(
        category: event.category!,
      );

      response.fold(
        (l) => emit(AudioStateError(message: l.message ?? 'Failed to connect')),
        (r) {
          emit(
            AudioStateLoaded(
              audios: r,
              category: Category(
                id: event.category?.id,
                name: event.category?.name??'',
                imageUrl: event.category?.imageUrl??''
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> _onFetchCategory(
      FetchCategory event, Emitter<AudioState> emit) async {
    final response =
        await homeRepository.getCategory(categoryId: event.categoryId);
    response.fold(
      (l) => emit(AudioStateError(message: l.message ?? 'Failed to connect')),
      (Category r) {
        AudioCategory category =
            AudioCategory(id: r.id, name: r.name, imageUrl: r.imageUrl);
        add(
          FetchAudios(
            category: category,
            categoryId: event.categoryId,
          ),
        );
      },
    );
  }
}
