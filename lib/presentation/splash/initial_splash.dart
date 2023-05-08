import 'package:dropandgouser/application/home/user_bloc/user_bloc.dart';
import 'package:dropandgouser/application/splash/splash_bloc/splash_bloc.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InitialSplashPage extends StatefulWidget {
  const InitialSplashPage({Key? key}) : super(key: key);

  @override
  State<InitialSplashPage> createState() => _InitialSplashPageState();
}

class _InitialSplashPageState extends State<InitialSplashPage> {
  final Toasts _toasts = Toasts();

  // late Timer _timer;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashStateAuthenticated) {
          if (getIt<UserService>().userData?.id != null) {
            context.read<UserBloc>().add(
                  FetchUser(userId: getIt<UserService>().userData!.id),
                );
          }
          getIt<NavigationService>().navigateToNamed(
            context: context,
            uri: NavigationService.homeRouteUri,
          );
        } else if (state is SplashStateUnauthenticated) {
          getIt<NavigationService>().navigateToNamed(
            context: context,
            uri: NavigationService.splashRouteUri,
          );
        } else if (state is SplashStateError) {
          _toasts.showToast(
            context,
            type: AlertType.Error,
            title: "Error",
            description: state.message,
          );
        }
        print('Stat is : $state');
      },
      child: Scaffold(
        body: SizedBox(
          height: context.height,
          width: context.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StandardText.headline1(
                context,
                'splash.title'.tr().toUpperCase(),
                height: 0.5,
              ),
              10.h.verticalGap,
              StandardText.headline6(
                context,
                'splash.caption'.tr().toUpperCase(),
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
