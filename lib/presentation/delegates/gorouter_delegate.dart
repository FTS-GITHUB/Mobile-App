import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/signup/complete_profile_page.dart';
import 'package:dropandgouser/presentation/signup/create_account_page.dart';
import 'package:dropandgouser/presentation/onboarding/achievement_info_page.dart';
import 'package:dropandgouser/presentation/onboarding/age_info_page.dart';
import 'package:dropandgouser/presentation/onboarding/gender_info_page.dart';
import 'package:dropandgouser/presentation/onboarding/user_level_info_page.dart';
import 'package:dropandgouser/presentation/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

class GoRouterDelegate {
  static final GoRouter routerConfig = GoRouter(
    initialLocation: NavigationService.splashRouteUri,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: NavigationService.splashRouteUri,
        name: NavigationService.splashRouteUri,
        builder: (context, routerState) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: NavigationService.onboardingGenderRouteUri,
        name: NavigationService.onboardingGenderRouteUri,
        builder: (context, routerState) {
          return const GenderInfoPage();
        },
      ),
      GoRoute(
        path: NavigationService.onboardingAgeRouteUri,
        name: NavigationService.onboardingAgeRouteUri,
        builder: (context, routerState) {
          return const AgeInfoPage();
        },
      ),
      GoRoute(
        path: NavigationService.onboardingAchievementRouteUri,
        name: NavigationService.onboardingAchievementRouteUri,
        builder: (context, routerState) {
          return const AchievementInfoPage();
        },
      ),//createAccountRouteUri
      GoRoute(
        path: NavigationService.onboardingLevelRouteUri,
        name: NavigationService.onboardingLevelRouteUri,
        builder: (context, routerState) {
          return const UserLevelInfoPage();
        },
      ),
      GoRoute(
        path: NavigationService.completeProfileRouteUri,
        name: NavigationService.completeProfileRouteUri,
        builder: (context, routerState) {
          return CompleteProfilePage();
        },
      ),
      GoRoute(
        path: NavigationService.createAccountRouteUri,
        name: NavigationService.createAccountRouteUri,
        builder: (context, routerState) {
          return CreateAccountPage(
            userData: routerState.extra as UserData?,
          );
        },
      ),
    ],
  );
}
