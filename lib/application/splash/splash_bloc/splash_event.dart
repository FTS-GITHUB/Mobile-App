part of 'splash_bloc.dart';

class SplashEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class CheckAuthState extends SplashEvent{
  CheckAuthState({
    required this.isAuthenticated,
});
  final bool isAuthenticated;

}

class AuthenticateBiometric extends SplashEvent{}
