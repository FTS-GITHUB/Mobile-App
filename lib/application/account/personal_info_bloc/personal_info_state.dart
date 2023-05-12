part of 'personal_info_bloc.dart';

abstract class PersonalInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PersonalInfoStateInitial extends PersonalInfoState {}

class PersonalInfoStateLoading extends PersonalInfoState {
}

class PersonalInfoStateLoaded extends PersonalInfoState {
  PersonalInfoStateLoaded({
    required this.userData,
});
  final UserData userData;
}

class PersonalInfoStateError extends PersonalInfoState {
  PersonalInfoStateError({
    required this.message,
  });

  final String message;
}
