import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

/// Signs in (or registers) with Google, translating transport errors
/// into [AuthFailure]. Cancellation codes are preserved so the UI can
/// stay silent for `google-signin-canceled`.
@lazySingleton
class SignInWithGoogle {
  SignInWithGoogle(this._repository);

  final AuthRepository _repository;

  Future<void> call({Role? role}) async {
    try {
      await _repository.signInWithGoogle(role: role);
    } on GoogleSignInException catch (e) {
      throw AuthFailure(code: e.code.name, message: e.description, cause: e);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(code: e.code, message: e.message, cause: e);
    } catch (e) {
      throw AuthFailure(code: 'generic', cause: e);
    }
  }
}
