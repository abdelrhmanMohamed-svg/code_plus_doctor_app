import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

/// Signs the current user out, surfacing failures as [AuthFailure].
@lazySingleton
class SignOut {
  SignOut(this._repository);

  final AuthRepository _repository;

  Future<void> call() async {
    try {
      await _repository.signOut();
    } catch (e) {
      throw AuthFailure(code: 'generic', cause: e);
    }
  }
}
