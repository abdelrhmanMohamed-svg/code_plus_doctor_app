import 'package:injectable/injectable.dart';

import 'package:doctor_hunt/apps/features/login/data/service/auth_service.dart';
import 'package:doctor_hunt/apps/features/profile/data/models/user_profile.dart';

import '../service/user_service.dart';
import 'user_repository.dart';

/// Concrete user repository — fetches user profile from Firestore via AuthService uid.
@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._authService, this._userService);

  final AuthService _authService;
  final UserService _userService;

  @override
  Future<UserProfile?> fetchCurrentUserProfile() async {
    final user = _authService.currentUser;
    if (user == null) return null;
    return _userService.getUserProfile(user.uid);
  }
}
