part of 'splash_bloc.dart';

class SplashState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SplashStateInitial extends SplashState{}

class SplashStateLoading extends SplashState{}

class SplashStateAuthenticated extends SplashState{}

class SplashStateUnauthenticated extends SplashState{}

class SplashStateError extends SplashState{
  SplashStateError({
    required this.message,
});
  final String message;
}
