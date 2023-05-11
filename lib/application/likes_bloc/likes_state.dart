import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:equatable/equatable.dart';

abstract class LikesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LikesStateInitial extends LikesState {}

class LikesStateLoading extends LikesState {}

class LikesStateLoaded extends LikesState {
  LikesStateLoaded({required this.userData,});
  final UserData userData;
}

class LikesStateError extends LikesState {
  LikesStateError({
    required this.message,
  });

  final String message;
}
