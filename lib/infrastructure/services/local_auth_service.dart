import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

final LocalAuthentication auth = LocalAuthentication();

class LocalAuthService {
  static Future<Either<ApiError, bool>> initialize() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          // authMessages: const <AuthMessages>[
          //   AndroidAuthMessages(
          //     biometricHint: '',
          //     cancelButton: 'No thanks',
          //   ),
          //   IOSAuthMessages(
          //     cancelButton: 'No thanks',
          //   ),
          // ],
          localizedReason: 'Please authenticate to enable access to app',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
          )).catchError((err){
            throw PlatformException(code: 404.toString(),message: err.toString(),);
      });
      final List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();
      print('List of Available biometrics: $availableBiometrics');
      return right(didAuthenticate);
    } on PlatformException catch (e) {
      print('Error message from local auth is: ${e.message}');
      return left(
        ApiError(message: e.message),
      );
    }
  }
}
