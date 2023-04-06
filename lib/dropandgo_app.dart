// ignore_for_file: always_specify_types

import 'dart:async';
import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropandgouser/application/complete_profile/cubit/country_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/rememberme_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/achievement_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/countries_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/dob_date_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/profile_file_cubit.dart';
import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:dropandgouser/shared/helpers/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/delegates/gorouter_delegate.dart';

class DropAndGoApp extends StatefulWidget {
  const DropAndGoApp({
    Key? key,
  }) : super(key: key);

  @override
  State<DropAndGoApp> createState() => _DropAndGoAppState();
}

class _DropAndGoAppState extends State<DropAndGoApp> {
  // late LoginRepository _loginRepository;
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final _networkNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _networkNotifier.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _initNetwork();
    SharedPreferenceHelper.instance.init();
    super.initState();

    initRepositories();
  }

  _initNetwork() {
    _connectivity = Connectivity();
    initConnectivity();
    listenNetworkState();
  }

  listenNetworkState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        _networkNotifier.value = true;
      } else {
        ConnectivityResult result = await _connectivity.checkConnectivity();
        if (result == ConnectivityResult.none) {
          _networkNotifier.value = true;
        } else {
          _networkNotifier.value = false;
        }
      }
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      await _updateConnectionStatus(ConnectivityResult.none);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      _networkNotifier.value = true;
    } else {
      _networkNotifier.value = false;
    }
  }

  initRepositories() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenderCubit>(
          create: (context) => GenderCubit(),
        ),
        BlocProvider<AgeCubit>(
          create: (context) => AgeCubit(),
        ),
        BlocProvider<AchievementCubit>(
          create: (context) => AchievementCubit(),
        ),
        BlocProvider<UserLevelCubit>(
          create: (context) => UserLevelCubit(),
        ),
        BlocProvider<ProfileFileCubit>(
          create: (context) => ProfileFileCubit(),
        ),
        BlocProvider<DobDateCubit>(
          create: (context) => DobDateCubit(),
        ),
        BlocProvider<CountriesCubit>(
          create: (context) => CountriesCubit(),
        ),
        BlocProvider<CountryCubit>(
          create: (context) => CountryCubit(),
        ),
        BlocProvider<RememberMeCubit>(
          create: (context) => RememberMeCubit(),
        ),
      ],//RememberMeCubit
      child: _DropAndGoApp(
        theme: DropAndGoTheme.standard,
        networkNotifier: _networkNotifier,
      ),
    );
  }
}

class _DropAndGoApp extends StatelessWidget {
  const _DropAndGoApp({
    Key? key,
    required this.theme,
    required this.networkNotifier,
  }) : super(key: key);
  final ValueNotifier networkNotifier;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const <Locale>[
        Locale('en'),
      ],
      //fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: Builder(builder: (context) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: GoRouterDelegate.routerConfig,
          builder: (BuildContext context, Widget? child) =>
              AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(
              // systemNavigationBarColor: LocalWalkersColors.primary,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1,
                ),
                child: Stack(
                  children: [
                    child ?? Container(),
                    ValueListenableBuilder(
                      valueListenable: networkNotifier,
                      builder: (context, value, state) {
                        return Container();
                        // return value ? const NoConnection() : Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          theme: theme,
        );
      }),
    );
  }
}
