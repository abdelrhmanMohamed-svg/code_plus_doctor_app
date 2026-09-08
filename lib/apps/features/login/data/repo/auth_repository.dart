import 'package:doctor_hunt/apps/features/profile/data/models/role.dart';

/// Abstract auth repository contract.
abstract class AuthRepository {
  /// Firebase session validity (true when Firebase user is non-null).
  Stream<bool> get authSessionChanges;

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    Role? role,
  });

  Future<void> signInWithGoogle({Role? role});

  Future<void> signOut();
}
