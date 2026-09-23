import 'package:injectable/injectable.dart';

import 'package:doctor_hunt/apps/features/common/auth/data/remote_data/auth_remote_data_source.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile.dart';

import '../service/user_service.dart';
import 'user_repository.dart';

/// Concrete user repository — fetches user profile from Firestore via AuthRemoteDataSource uid.
@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._remoteDataSource, this._userService);

  final AuthRemoteDataSource _remoteDataSource;
  final UserService _userService;

  @override
  Future<UserProfile?> fetchCurrentUserProfile() async {
    final user = _remoteDataSource.currentUser;
    if (user == null) return null;
    return _userService.getUserProfile(user.uid);
  }
}
