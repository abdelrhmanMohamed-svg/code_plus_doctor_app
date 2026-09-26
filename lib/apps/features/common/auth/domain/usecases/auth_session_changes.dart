import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

/// Exposes the Firebase session validity stream (true when signed in).
@lazySingleton
class AuthSessionChanges {
  AuthSessionChanges(this._repository);

  final AuthRepository _repository;

  Stream<bool> call() => _repository.authSessionChanges;
}
