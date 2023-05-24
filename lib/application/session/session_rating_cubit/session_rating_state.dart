part of 'session_rating_cubit.dart';

abstract class SessionRatingState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SessionRatingStateInitial extends SessionRatingState{}

class SessionRatingStateUploading extends SessionRatingState{}

class SessionRatingStateUploaded extends SessionRatingState{
  SessionRatingStateUploaded();
}

class SessionRatingStateError extends SessionRatingState{
  SessionRatingStateError({
    required this.message,
  });
  final String message;
}
