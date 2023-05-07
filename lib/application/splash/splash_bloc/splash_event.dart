part of 'splash_bloc.dart';

class SplashEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class CheckAuthState extends SplashEvent{}

class GetUser extends SplashEvent{
  GetUser({
    required this.userId,
  });
  final String userId;
}

class GetUserSettings extends SplashEvent{
  GetUserSettings({
    required this.userId,
});
  final String userId;
}
