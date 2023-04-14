part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupStateInitial extends SignupState {}

class SignupStateCreatingAccount extends SignupState {}

class SignupStateCreatedAccount extends SignupState {
  SignupStateCreatedAccount({
    required this.userId,
  });

  final String userId;
}

class SignupStateUploadedPicture extends SignupState {
  SignupStateUploadedPicture({
    required this.profilePicUrl,
    required this.userId,
});
  final String profilePicUrl;
  final String userId;
}

class SignupStateUploadedData extends SignupState {}

class SignupStateError extends SignupState {
  SignupStateError({
    required this.message,
  });

  final String message;
}
