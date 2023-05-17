part of 'session_bloc.dart';

abstract class SessionState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SessionStateInitial extends SessionState{}

class SessionStateUploading extends SessionState{}

class SessionStateUploaded extends SessionState{
  SessionStateUploaded();
}

class SessionStateError extends SessionState{
  SessionStateError({
    required this.message,
});
  final String message;
}
