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
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/domain/i_setting_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/setting/setting_repository.dart';
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
  late ISettingRepository _settingRepository;

  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // final _networkNotifier = ValueNotifier(false);

  @override
  void dispose() {
    // _networkNotifier.dispose();
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    SharedPreferenceHelper.instance.init();
    super.initState();

    initRepositories();
  }

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result = ConnectivityResult.none;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException {
  //     await _updateConnectionStatus(ConnectivityResult.none);
  //   }
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   if (result == ConnectivityResult.none) {
  //     _networkNotifier.value = true;
  //   } else {
  //     _networkNotifier.value = false;
  //   }
  // }

  initRepositories() {
    _settingRepository = SettingRepository(
      firestoreRepository: getIt<ICloudFirestoreRepository>(),
    );
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
        BlocProvider<SettingBloc>(
          create: (context) => SettingBloc(
            settingRepository: _settingRepository,
          )..add(FetchAchievementSettings()),
        ),
        BlocProvider<GenderSettingBloc>(
          create: (context) => SettingBloc(
            settingRepository: _settingRepository,
          )..add(FetchGenderSettings()),
        ),
        BlocProvider<AgeSettingBloc>(
          create: (context) => SettingBloc(
            settingRepository: _settingRepository,
          )..add(FetchAgeSettings()),
        ),
        BlocProvider<CompleteProfileSettingBloc>(
          create: (context) => SettingBloc(
            settingRepository: _settingRepository,
          )..add(FetchCompleteProfileSettings()),
        ),
        BlocProvider<CreateAccountSettingBloc>(
          create: (context) => SettingBloc(
            settingRepository: _settingRepository,
          )..add(FetchCreateAccountSettings()),
        ),
        BlocProvider<RecommendationSettingBloc>(
          create: (context) => SettingBloc(
            settingRepository: _settingRepository,
          )..add(FetchRecommendationSettings()),
        ),
        BlocProvider<SignupSuccessSettingBloc>(
          create: (context) => SettingBloc(
            settingRepository: _settingRepository,
          )..add(FetchSignupSuccessSettings()),
        ),
      ], //SettingBloc
      child: _DropAndGoApp(
        theme: DropAndGoTheme.standard,
        // networkNotifier: _networkNotifier,
      ),
    );
  }
}

class _DropAndGoApp extends StatelessWidget {
  const _DropAndGoApp({
    Key? key,
    required this.theme,
    // required this.networkNotifier,
  }) : super(key: key);

  // final ValueNotifier networkNotifier;
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
                  child: child ?? Container()
                  // Stack(
                  //   children: [
                  //     child ?? Container(),
                  //     ValueListenableBuilder(
                  //       valueListenable: networkNotifier,
                  //       builder: (context, value, state) {
                  //         return Container();
                  //         // return value ? const NoConnection() : Container();
                  //       },
                  //     ),
                  //   ],
                  // ),
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
