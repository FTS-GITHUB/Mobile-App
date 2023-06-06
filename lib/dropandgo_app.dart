// ignore_for_file: always_specify_types

import 'dart:ui' as ui;

import 'package:dropandgouser/application/account/account_cubit/biometric_id_cubit.dart';
import 'package:dropandgouser/application/account/account_cubit/face_id_cubit.dart';
import 'package:dropandgouser/application/account/account_cubit/preference_cubit.dart';
import 'package:dropandgouser/application/account/account_cubit/remind_bedtime_cubit.dart';
import 'package:dropandgouser/application/account/account_cubit/set_reminder_cubit.dart';
import 'package:dropandgouser/application/account/account_setting_bloc/account_setting_bloc.dart';
import 'package:dropandgouser/application/account/change_password_bloc/change_password_bloc.dart';
import 'package:dropandgouser/application/account/personal_info_bloc/personal_info_bloc.dart';
import 'package:dropandgouser/application/analytics/analytics_bloc/analytics_bloc.dart';
import 'package:dropandgouser/application/audio_bloc/audio_bloc.dart';
import 'package:dropandgouser/application/audio_bloc/audio_cubit/download_progress_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/countries_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/country_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/dob_date_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/profile_file_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/rememberme_cubit.dart';
import 'package:dropandgouser/application/download/download_bloc/download_bloc.dart';
import 'package:dropandgouser/application/home/home_bloc/home_bloc.dart';
import 'package:dropandgouser/application/home/user_bloc/user_bloc.dart';
import 'package:dropandgouser/application/likes_bloc/likes_cubit.dart';
import 'package:dropandgouser/application/login/cubit/login_obscurepassword_cubit.dart';
import 'package:dropandgouser/application/login/cubit/login_remember_cubit.dart';
import 'package:dropandgouser/application/login/login_bloc/login_bloc.dart';
import 'package:dropandgouser/application/onboarding/cubit/achievement_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/age_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/user_level_cubit.dart';
import 'package:dropandgouser/application/search/cubit/is_seearch_active.dart';
import 'package:dropandgouser/application/search/search_found_bloc/search_found_bloc.dart';
import 'package:dropandgouser/application/session/all_session_cubit/all_session_bloc.dart';
import 'package:dropandgouser/application/session/session_bloc/session_bloc.dart';
import 'package:dropandgouser/application/session/session_cubit/session_completed_cubit.dart';
import 'package:dropandgouser/application/session/session_rating_cubit/session_rating_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/application/signup/signup_bloc.dart';
import 'package:dropandgouser/application/splash/splash_bloc/splash_bloc.dart';
import 'package:dropandgouser/domain/account/i_account_repository.dart';
import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/i_setting_repository.dart';
import 'package:dropandgouser/domain/login/i_login_repository.dart';
import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/domain/services/i_cloud_firestore_repository.dart';
import 'package:dropandgouser/domain/services/i_storage_repository.dart';
import 'package:dropandgouser/domain/session/i_session_repository.dart';
import 'package:dropandgouser/domain/signup/i_signup_repository.dart';
import 'package:dropandgouser/infrastructure/account/account_repository.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/home/home_repository.dart';
import 'package:dropandgouser/infrastructure/login/login_repository.dart';
import 'package:dropandgouser/infrastructure/services/local_database_service.dart';
import 'package:dropandgouser/infrastructure/session/session_repository.dart';
import 'package:dropandgouser/infrastructure/setting/setting_repository.dart';
import 'package:dropandgouser/infrastructure/signup/signup_repository.dart';
import 'package:dropandgouser/infrastructure/splash/splash_repository.dart';
import 'package:dropandgouser/shared/app_lifecycle/life_cycle_manager.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:dropandgouser/shared/helpers/theme.dart';
import 'package:dropandgouser/shared/screen_util/screen_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/main/cubit/main_navbar_cubit.dart';
import 'application/search/search_history_bloc/search_bloc.dart';
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
  late SplashRepository _splashRepository;
  late IHomeRepository _homeRepository;
  late IAccountRepository _accountRepository;
  late ISessionRepository _sessionRepository;

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
    localDatabaseService=LocalDatabaseService();
    localDatabaseService?.initialize();
    initFirebase();
    super.initState();
    initRepositories();
  }

  initFirebase()async{

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
      firestoreRepository: _cloudFirestoreRepository,
    );
    _splashRepository = SplashRepository(_cloudFirestoreRepository);
    _homeRepository = HomeRepository(
      cloudFirestoreRepository: _cloudFirestoreRepository,
    );
    _accountRepository = AccountRepository(
      firestoreRepository: _cloudFirestoreRepository,
    );
    _sessionRepository = SessionRepository(
      firestoreRepository: _cloudFirestoreRepository,
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
            signupRepository: _signupRepository,
          ),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => LoginBloc(
            loginRepository: _loginRepository,
            signupRepository: _signupRepository,
          ),
        ),
        BlocProvider<MainNavBarCubit>(
          create: (context) => MainNavBarCubit(),
        ),
        BlocProvider<IsSearchActive>(
          create: (context) => IsSearchActive(),
        ),
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(
            _authRepository,
            _splashRepository,
          )..add(CheckAuthState(
              isAuthenticated: false,
            )),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(homeRepository: _homeRepository),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            authRepository: _authRepository,
            splashRepository: _splashRepository,
          ),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(
            homeRepository: _homeRepository,
          ),
        ),
        BlocProvider<SearchFoundBloc>(
          create: (context) => SearchFoundBloc(homeRepository: _homeRepository),
        ),
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc(homeRepository: _homeRepository),
        ),
        BlocProvider<LikesCubit>(
          create: (context) => LikesCubit(homeRepository: _homeRepository),
        ),
        BlocProvider<PersonalInfoBloc>(
          create: (context) => PersonalInfoBloc(
            accountRepository: _accountRepository,
            signupRepository: _signupRepository,
          ),
        ),
        BlocProvider<RemindBedTimeCubit>(
          create: (context) => RemindBedTimeCubit(),
        ),
        BlocProvider<SetReminderCubit>(
          create: (context) => SetReminderCubit(),
        ),
        BlocProvider<AccountSettingBloc>(
          create: (context) => AccountSettingBloc(
            accountRepository: _accountRepository,
          ),
        ),
        BlocProvider<BiometricCubit>(
          create: (context) => BiometricCubit(),
        ),
        BlocProvider<FaceIdCubit>(
          create: (context) => FaceIdCubit(),
        ),
        BlocProvider<RememberMeCubit>(
          create: (context) => RememberMeCubit(),
        ),
        BlocProvider<ChangePasswordBloc>(
          create: (context) =>
              ChangePasswordBloc(authRepository: _authRepository),
        ),
        BlocProvider<PreferenceCubit>(
          create: (context) => PreferenceCubit(),
        ),
        BlocProvider<SessionBloc>(
          create: (context) => SessionBloc(
            sessionRepository: _sessionRepository,
          ),
        ),
        BlocProvider<SessionCompletedCubit>(
          create: (context) => SessionCompletedCubit(),
        ),
        BlocProvider<AnalyticsBloc>(
          create: (context) => AnalyticsBloc(
            sessionRepository: _sessionRepository,
          ),
        ),
        BlocProvider<SessionRatingCubit>(
          create: (context) => SessionRatingCubit(
            sessionRepository: _sessionRepository,
          ),
        ),
        BlocProvider<AllSessionBloc>(
          create: (context) => AllSessionBloc(
            sessionRepository: _sessionRepository,
          ),
        ),
        BlocProvider<DownloadBloc>(
          create: (context) => DownloadBloc(
            homeRepository: _homeRepository,
          ),
        ),
        BlocProvider<DownloadProgressCubit>(
          create: (context) => DownloadProgressCubit(),
        ),
      ], // DownloadProgressCubit
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
        return LifeCycleManager(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: GoRouterDelegate.routerConfig,
            builder: (BuildContext context, Widget? child) {
              ScreenUtilSetup.initialize(context);
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark.copyWith(
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: 1,
                      ),
                      child: child ?? Container()),
                ),
              );
            },
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            theme: theme,
          ),
        );
      }),
    );
  }
}
