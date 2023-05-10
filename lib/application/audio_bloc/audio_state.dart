part of 'audio_bloc.dart';

abstract class AudioState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AudioStateInitial extends AudioState{}

class AudioStateLoading extends AudioState{}

class AudioStateLoaded extends AudioState{
  AudioStateLoaded({
    required this.audios,
    required this.category,
});

  final List<Audio> audios;
  final Category category;
}

class AudioStateError extends AudioState{
  AudioStateError({
    required this.message,
});
  final String message;
}
