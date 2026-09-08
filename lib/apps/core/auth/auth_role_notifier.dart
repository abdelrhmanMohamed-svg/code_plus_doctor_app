import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../features/login/data/repo/auth_repository.dart';
import '../../features/profile/data/models/role.dart';
import '../../features/profile/data/models/user_profile.dart';
import '../../features/profile/data/repo/user_repository.dart';

enum AuthSessionStatus { unknown, authenticated, unauthenticated }

/// Combined session + role state so both update atomically.
class AuthRoleState {
  const AuthRoleState({required this.status, this.role = Role.patient});

  final AuthSessionStatus status;
  final Role role;

  AuthRoleState copyWith({AuthSessionStatus? status, Role? role}) {
    return AuthRoleState(
      status: status ?? this.status,
      role: role ?? this.role,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AuthRoleState && other.status == status && other.role == role;

  @override
  int get hashCode => Object.hash(status, role);
}

/// Holds the session status and resolved role as one atomic value.
/// Keeps `status == unknown` while the role is loading, then flips to
/// `authenticated` only after the role resolves — so the router never
/// routes on a stale patient default.
@lazySingleton
class AuthRoleNotifier extends ValueNotifier<AuthRoleState> {
  AuthRoleNotifier(this._repository, this._userRepository)
    : super(const AuthRoleState(status: AuthSessionStatus.unknown)) {
    _subscription = _repository.authSessionChanges.listen(
      (isAuthenticated) {
        if (isAuthenticated) {
          value = const AuthRoleState(status: AuthSessionStatus.unknown);
          _resolveRole();
        } else {
          value = const AuthRoleState(
            status: AuthSessionStatus.unauthenticated,
          );
        }
      },
      onError: (_) {
        value = const AuthRoleState(status: AuthSessionStatus.unauthenticated);
      },
    );
  }

  static const _maxRoleResolveAttempts = 5;
  static const _roleResolveRetryDelay = Duration(milliseconds: 300);

  final AuthRepository _repository;
  final UserRepository _userRepository;
  late final StreamSubscription<bool> _subscription;

  Future<void> _resolveRole() async {
    // A freshly created profile may not be readable yet right after the auth
    // event fires, so retry briefly before committing to a role.
    UserProfile? profile;
    for (var attempt = 0; attempt < _maxRoleResolveAttempts; attempt++) {
      try {
        profile = await _userRepository.fetchCurrentUserProfile();
      } catch (_) {
        profile = null;
      }
      if (profile != null) break;
      if (attempt < _maxRoleResolveAttempts - 1) {
        await Future<void>.delayed(_roleResolveRetryDelay);
      }
    }
    value = AuthRoleState(
      status: AuthSessionStatus.authenticated,
      role: profile?.role ?? Role.patient,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
