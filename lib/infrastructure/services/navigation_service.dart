import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}

abstract class NavigationService {
  static const String initialSplashRouteUri = '/';
  static const String splashRouteUri = 'splash';
  static const String loginRouteUri = 'login';
  static const String underConstruction = 'under-construction';
  static const String onboardingGenderRouteUri = 'select-gender';
  static const String onboardingAgeRouteUri = 'select-age';
  static const String onboardingAchievementRouteUri = 'select-achievement';
  static const String onboardingLevelRouteUri = 'select-level';
  static const String completeProfileRouteUri = 'complete-profile';
  static const String createAccountRouteUri = 'create-account';
  static const String forgetPasswordRouteUri = 'forget-password';
  static const String homeRouteUri = 'home';
  static const String analyticsRouteUri = 'analytics';
  static const String downloadsRouteUri = 'downloads';
  static const String accountRouteUri = 'account';
  static const String categoriesRouteUri = 'categories';
  static const String searchRouteUri = 'search';
  static const String personalInfoRouteUri = 'edit-profile';
  static const String notificationRouteUri = 'notification';
  static const String preferenceRouteUri = 'preference';
  static const String securityRouteUri = 'security';
  static const String changePasswordRouteUri = 'change-password';
  static const String categoryDetailRouteUri = 'category-detail';
  // static const String plyaerAudioRouteUri = 'audio';
  //

  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  void navigateBack({required BuildContext context});

  Future<void> launchUrl({
    required String urlString,
    required bool external,
  });

  void pushNamed({
    required BuildContext context,
    required String uri,
    Object? data,
    Map<String, String> params = const <String, String>{},
  });
}

class GoRouterNavigationService extends NavigationService
    with NavigationServiceMixins {
  GoRouterNavigationService();

  @override
  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  }) =>
      context.goNamed(
        uri,
        extra: data,
      );

  @override
  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  }) =>
      context.goNamed(uri, extra: data);

  @override
  void navigateBack({required BuildContext context}) => context.pop();

  @override
  void pushNamed({
    required BuildContext context,
    required String uri,
    Object? data,
    Map<String, String> params = const <String, String>{},
  }) {
    context.pushNamed(
      uri,
      extra: data,
      params: params,
    );
  }
}

mixin NavigationServiceMixins implements NavigationService {
  @override
  Future<void> launchUrl({
    required String urlString,
    required bool external,
  }) async {
    if (await launcher.canLaunchUrl(Uri.parse(urlString))) {
      await launcher.launchUrl(
        Uri.parse(urlString),
        mode: external
            ? launcher.LaunchMode.externalApplication
            : launcher.LaunchMode.inAppWebView,
        webViewConfiguration: const launcher.WebViewConfiguration(),
      );
    }
  }
}
