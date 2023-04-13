part of 'signup_bloc.dart';

abstract class SignupState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SignupStateInitial extends SignupState{}

class SignupStateCreatingAccount extends SignupState{}

class SignupStateCreatedAccount extends SignupState{}

class SignupStateUploadedData extends SignupState{}

class SignupStateError extends SignupState{
  SignupStateError({
    required this.message,
});
  final String message;
}
