import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../features/login/data/repo/auth_repository.dart';

enum AuthSessionStatus { unknown, authenticated, unauthenticated }

@lazySingleton
class AuthStatusNotifier extends ValueNotifier<AuthSessionStatus> {
  AuthStatusNotifier(this._repository) : super(AuthSessionStatus.unknown) {
    _subscription = _repository.authSessionChanges.listen(
      (isAuthenticated) {
        value = isAuthenticated
            ? AuthSessionStatus.authenticated
            : AuthSessionStatus.unauthenticated;
      },
      onError: (_) {
        value = AuthSessionStatus.unauthenticated;
      },
    );
  }

  final AuthRepository _repository;
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
