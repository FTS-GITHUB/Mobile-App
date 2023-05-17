import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(
    this._firebaseAuth,
    this._googleSignIn,
  );

  final firebaseAuth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<void> signOut() => Future.wait([
        _firebaseAuth.signOut(),
      ]);

  @override
  Future<Either<ApiError, String>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user?.uid != null) {
        return right(response.user!.uid);
      } else {
        throw firebaseAuth.FirebaseAuthException(
            code: '404', message: 'Failed to register');
      }
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return left(e.toApiAuthError());
    }
  }

  @override
  Future<Either<ApiError, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response.user!.uid);
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return left(e.toApiAuthError());
    }
  }

  @override
  String? get userId => _firebaseAuth.currentUser?.uid;

  @override
  Future<Either<ApiError, Unit>> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(
        email: email,
      )
          .catchError((err) {
        throw firebaseAuth.FirebaseAuthException(
          code: err.code,
          message: err.message,
        );
      });
      return right(unit);
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return left(
        e.toApiAuthError(),
      );
    }
  }

  @override
  Future<firebaseAuth.User?> getSignedInUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<Either<ApiError, Unit>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final firebaseAuth.AuthCredential credentials =
          firebaseAuth.EmailAuthProvider.credential(
        email: _firebaseAuth.currentUser!.email!,
        password: oldPassword,
      );
      await _firebaseAuth.currentUser!
          .reauthenticateWithCredential(credentials)
          .then(
            (_) => _firebaseAuth.currentUser!.updatePassword(newPassword),
          );
      return right(unit);
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return left(e.toApiError());
    }
  }

  @override
  Future<Either<ApiError, firebaseAuth.UserCredential>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return left(
          ApiError(
            message: 'Cancelled by user',
          ),
        );
      }

      final googleAuth = await googleUser.authentication;

      final authCredential = firebaseAuth.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((r) => right(r));
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return left(
        e.toApiError(),
      );
    }
  }
}
