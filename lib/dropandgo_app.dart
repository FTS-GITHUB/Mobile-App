// ignore_for_file: always_specify_types

import 'dart:ui' as ui;

import 'package:dropandgouser/application/complete_profile/cubit/countries_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/country_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/dob_date_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/profile_file_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/rememberme_cubit.dart';
import 'package:dropandgouser/application/login/cubit/login_obscurepassword_cubit.dart';
import 'package:dropandgouser/application/login/cubit/login_remember_cubit.dart';
import 'package:dropandgouser/application/login/login_bloc/login_bloc.dart';
import 'package:dropandgouser/application/onboarding/cubit/achievement_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/application/search/cubit/is_seearch_active.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/application/signup/signup_bloc.dart';
import 'package:dropandgouser/domain/i_setting_repository.dart';
import 'package:dropandgouser/domain/login/i_login_repository.dart';
import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/i_storage_repository.dart';
import 'package:dropandgouser/domain/signup/i_signup_repository.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/login/login_repository.dart';
import 'package:dropandgouser/infrastructure/setting/setting_repository.dart';
import 'package:dropandgouser/infrastructure/signup/signup_repository.dart';
import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:dropandgouser/shared/helpers/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/main/cubit/main_navbar_cubit.dart';
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
  late IAuthRepository _authRepository;
  late ICloudFirestoreRepository _cloudFirestoreRepository;
  late IStorageRepository _storageRepository;
  late ISignupRepository _signupRepository;
  late ILoginRepository _loginRepository;

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
    _authRepository = getIt<IAuthRepository>();
    _cloudFirestoreRepository = getIt<ICloudFirestoreRepository>();
    _storageRepository = getIt<IStorageRepository>();
    _signupRepository = SignupRepository(
      authRepository: _authRepository,
      firestoreRepository: _cloudFirestoreRepository,
      storageRepository: _storageRepository,
    );
    _loginRepository = LoginRepository(
      authRepository: _authRepository,
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
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(
            signupRepository: _signupRepository,
          ),
        ),
        BlocProvider<PostSignupBloc>(
          create: (context) => SignupBloc(
            signupRepository: _signupRepository,
          ),
        ),
        BlocProvider<UploadPictureSignupBloc>(
          create: (context) => SignupBloc(
            signupRepository: _signupRepository,
          ),
        ),
        BlocProvider<LoginObscurePasswordCubit>(
          create: (context) => LoginObscurePasswordCubit(),
        ),
        BlocProvider<LoginRememberCubit>(
          create: (context) => LoginRememberCubit(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            loginRepository: _loginRepository,
          ),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => LoginBloc(
            loginRepository: _loginRepository,
          ),
        ),
        BlocProvider<MainNavBarCubit>(
          create: (context) => MainNavBarCubit(),
        ),
        BlocProvider<IsSearchActive>(
          create: (context) => IsSearchActive(),
        ),
      ], //IsSearchActive
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
