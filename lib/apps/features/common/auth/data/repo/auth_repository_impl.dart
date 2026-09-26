import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/service/user_service.dart';
import 'package:injectable/injectable.dart';

import '../../../profile/data/models/role.dart';
import '../../domain/repositories/auth_repository.dart';
import '../remote_data/auth_remote_data_source.dart';

/// Concrete auth repository — orchestrates the Firebase transport and
/// Firestore profile writes. Raw transport errors bubble up to the use cases.
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._userService);

  final AuthRemoteDataSource _remoteDataSource;
  final UserService _userService;

  @override
  Stream<bool> get authSessionChanges =>
      _remoteDataSource.authStateChanges.map((user) => user != null);

  @override
  Future<void> signIn({required String email, required String password}) {
    return _remoteDataSource.signInWithEmail(email: email, password: password);
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    Role? role,
  }) async {
    final credential = await _remoteDataSource.signUpWithEmail(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw StateError('missing-user');
    }

    await user.updateDisplayName(name);

    final profile = UserProfile(
      uid: user.uid,
      name: name,
      email: email,
      createdAt: DateTime.now(),
      role: role ?? Role.patient,
    );
    await _userService.createUserProfile(profile);
  }

  @override
  Future<void> signInWithGoogle({Role? role}) async {
    final credential = await _remoteDataSource.signInWithGoogle();
    final user = credential.user;
    if (user == null) {
      throw StateError('missing-user');
    }

    final existing = await _userService.getUserProfile(user.uid);
    if (existing != null) return;

    final profile = UserProfile(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      createdAt: DateTime.now(),
      role: role ?? Role.patient,
    );
    await _userService.createUserProfile(profile);
  }

  @override
  Future<void> signOut() => _remoteDataSource.signOut();
}
