part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UploadSession extends SessionEvent{
  UploadSession({
    required this.userId,
    required this.session,
});
  final String userId;
  final Session session;
}
