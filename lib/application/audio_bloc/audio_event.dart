part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchAudios extends AudioEvent{
  FetchAudios({
    required this.categoryId,
});
  final String categoryId;
}

class FetchCategory extends AudioEvent{
  FetchCategory({
    required this.categoryId,
    required this.audios,
  });

  final List<Audio> audios;
  final String categoryId;
}
