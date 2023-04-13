import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:dropandgouser/shared/extensions/firebase_exception.dart';
import 'package:dropandgouser/shared/network/domain/api_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(
    this._firebaseAuth,
  );

  final FirebaseAuth _firebaseAuth;
  // final GoogleSignIn

  @override
  Future<void> signOut() => Future.wait([
        _firebaseAuth.signOut(),
      ]);

  @override
  Future<Either<ApiError, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return left(e.toApiAuthError());
    }
  }

  @override
  Future<Either<ApiError, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
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
        throw FirebaseAuthException;
      });
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(
        e.toApiAuthError(),
      );
    }
  }

// @override
// Future<Either<ApiError, Unit>> signInWithGoogle() async {
//   try {
//     final googleUser = await _googleSignIn.signIn();
//
//     if (googleUser == null) {
//       return left(const AuthFailure.cancelledByUser());
//     }
//
//     final googleAuth = await googleUser.authentication;
//
//     final authCredential = firebase_auth.GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken,
//       accessToken: googleAuth.accessToken,
//     );
//
//     return _firebaseAuth
//         .signInWithCredential(authCredential)
//         .then((r) => right(unit));
//   } on firebase_auth.FirebaseAuthException catch (_) {
//     return left(const AuthFailure.serverError());
//   }
// }
}
