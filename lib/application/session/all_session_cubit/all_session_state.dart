part of 'all_session_bloc.dart';

abstract class AllSessionState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AllSessionStateInitial extends AllSessionState{}

class AllSessionStateLoading extends AllSessionState{}

class AllSessionStateLoaded extends AllSessionState{
  AllSessionStateLoaded();
}

class AllSessionStateError extends AllSessionState{
  AllSessionStateError({
    required this.message,
  });
  final String message;
}
