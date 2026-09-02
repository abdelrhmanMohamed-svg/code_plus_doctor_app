import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'package:doctor_hunt/apps/features/profile/data/models/user_profile.dart';
import 'package:doctor_hunt/apps/features/profile/data/service/user_service.dart';

import '../service/auth_service.dart';
import 'auth_repository.dart';

/// Concrete auth repository — orchestrates auth + Firestore profile writes.
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authService, this._userService);

  final AuthService _authService;
  final UserService _userService;

  @override
  Stream<bool> get authSessionChanges =>
      _authService.authStateChanges.map((user) => user != null);

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _authService.signInWithEmail(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(code: e.code, message: e.message, cause: e);
    } catch (e) {
      throw AuthFailure(code: 'generic', cause: e);
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw AuthFailure(code: 'missing-user');
      }

      await user.updateDisplayName(name);

      final profile = UserProfile(
        uid: user.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );
      await _userService.createUserProfile(profile);
    } on AuthFailure {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(code: e.code, message: e.message, cause: e);
    } catch (e) {
      throw AuthFailure(code: 'generic', cause: e);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final credential = await _authService.signInWithGoogle();
      final user = credential.user;
      if (user == null) {
        throw AuthFailure(code: 'missing-user');
      }

      final existing = await _userService.getUserProfile(user.uid);
      if (existing != null) return;

      final profile = UserProfile(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        createdAt: DateTime.now(),
      );
      await _userService.createUserProfile(profile);
    } on AuthFailure {
      rethrow;
    } on GoogleSignInException catch (e) {
      throw AuthFailure(code: e.code.name, message: e.description, cause: e);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(code: e.code, message: e.message, cause: e);
    } catch (e) {
      throw AuthFailure(code: 'generic', cause: e);
    }
  }

  @override
  Future<void> signOut() => _authService.signOut();
}
