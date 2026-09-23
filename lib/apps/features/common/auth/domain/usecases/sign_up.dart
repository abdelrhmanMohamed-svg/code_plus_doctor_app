import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

/// Registers a new user, translating transport errors into [AuthFailure].
@lazySingleton
class SignUp {
  SignUp(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String name,
    required String email,
    required String password,
    Role? role,
  }) async {
    try {
      await _repository.signUp(
        name: name,
        email: email,
        password: password,
        role: role,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(code: e.code, message: e.message, cause: e);
    } catch (e) {
      throw AuthFailure(code: 'generic', cause: e);
    }
  }
}
