import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

/// Signs an existing user in with email + password, translating
/// transport errors into [AuthFailure].
@lazySingleton
class SignIn {
  SignIn(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String email, required String password}) async {
    try {
      await _repository.signIn(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(code: e.code, message: e.message, cause: e);
    } catch (e) {
      throw AuthFailure(code: 'generic', cause: e);
    }
  }
}
