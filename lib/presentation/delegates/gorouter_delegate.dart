import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/account_page.dart';
import 'package:dropandgouser/presentation/account/personal_info_page.dart';
import 'package:dropandgouser/presentation/analytics/analytics_page.dart';
import 'package:dropandgouser/presentation/categories/categories_page.dart';
import 'package:dropandgouser/presentation/downloads/downloads_page.dart';
import 'package:dropandgouser/presentation/forget_password/forget_password_page.dart';
import 'package:dropandgouser/presentation/home/home_page.dart';
import 'package:dropandgouser/presentation/login/login_page.dart';
import 'package:dropandgouser/presentation/main_page/main_page.dart';
import 'package:dropandgouser/presentation/onboarding/achievement_info_page.dart';
import 'package:dropandgouser/presentation/onboarding/age_info_page.dart';
import 'package:dropandgouser/presentation/onboarding/gender_info_page.dart';
import 'package:dropandgouser/presentation/onboarding/user_level_info_page.dart';
import 'package:dropandgouser/presentation/search/search_page.dart';
import 'package:dropandgouser/presentation/signup/complete_profile_page.dart';
import 'package:dropandgouser/presentation/signup/create_account_page.dart';
import 'package:dropandgouser/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class GoRouterDelegate {
  static final GoRouter routerConfig = GoRouter(
    initialLocation: '/${NavigationService.homeRouteUri}',
    navigatorKey:_rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: NavigationService.splashRouteUri,
        name: NavigationService.splashRouteUri,
        builder: (context, routerState) {
          return const SplashPage();
        },
      ),
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.onboardingGenderRouteUri}",
        name: NavigationService.onboardingGenderRouteUri,
        builder: (context, routerState) {
          return const GenderInfoPage();
        },
      ),
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.onboardingAgeRouteUri}",
        name: NavigationService.onboardingAgeRouteUri,
        builder: (context, routerState) {
          return const AgeInfoPage();
        },
      ),
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.onboardingAchievementRouteUri}",
        name: NavigationService.onboardingAchievementRouteUri,
        builder: (context, routerState) {
          return const AchievementInfoPage();
        },
      ),//createAccountRouteUri
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.onboardingLevelRouteUri}",
        name: NavigationService.onboardingLevelRouteUri,
        builder: (context, routerState) {
          return const UserLevelInfoPage();
        },
      ),
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.completeProfileRouteUri}",
        name: NavigationService.completeProfileRouteUri,
        builder: (context, routerState) {
          return const CompleteProfilePage();
        },
      ),
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.createAccountRouteUri}",
        name: NavigationService.createAccountRouteUri,
        builder: (context, routerState) {
          return CreateAccountPage(
            userData: routerState.extra as UserData?,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.loginRouteUri}",
        name: NavigationService.loginRouteUri,
        builder: (context, routerState) {
          return const LoginPage();
        },
      ),
      GoRoute(
        parentNavigatorKey:_rootNavigatorKey,
        path: "/${NavigationService.forgetPasswordRouteUri}",
        name: NavigationService.forgetPasswordRouteUri,
        builder: (context, routerState) {
          return const ForgetPasswordPage();
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/${NavigationService.homeRouteUri}',
            name: NavigationService.homeRouteUri,
            builder: (context, routerState) {
              return const HomePage();
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: NavigationService.categoriesRouteUri,
                name: NavigationService.categoriesRouteUri,
                builder: (context, routerState) {
                  return const CategoriesPage();
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                // path: ':${NavigationService.searchRouteUri}',
                path: NavigationService.searchRouteUri,
                name: NavigationService.searchRouteUri,
                builder: (context, routerState) {
                  return const SearchPage();
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: NavigationService.downloadsRouteUri,
                name: NavigationService.downloadsRouteUri,
                builder: (context, routerState) {
                  return const DownloadsPage();
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: NavigationService.analyticsRouteUri,
                name: NavigationService.analyticsRouteUri,
                builder: (context, routerState) {
                  return const AnalyticsPage();
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: NavigationService.accountRouteUri,
                name: NavigationService.accountRouteUri,
                builder: (context, routerState) {
                  return const AccountPage();
                },
                routes: [
                  GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: NavigationService.personalInfoRouteUri,
                    name: NavigationService.personalInfoRouteUri,
                    builder: (context, routerState) {
                      return const PersonalInfoPage();
                    },
                  ),
                ],
              ),
            ]
          ),
        ],
        builder: (context, routerState, child){
          return MainPage(child: child);
        }
      ),
    ],
  );
}
