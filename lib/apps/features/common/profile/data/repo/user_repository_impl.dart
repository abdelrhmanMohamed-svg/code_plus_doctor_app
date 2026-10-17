import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:doctor_hunt/apps/features/common/auth/data/remote_data/auth_remote_data_source.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile.dart';

import '../service/user_service.dart';
import 'user_repository.dart';

import 'dart:async';

/// Concrete user repository — fetches user profile from Firestore via AuthRemoteDataSource uid.
@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._remoteDataSource, this._userService);

  final AuthRemoteDataSource _remoteDataSource;
  final UserService _userService;

  final _profileController = StreamController<UserProfile?>.broadcast();

  @override
  Stream<UserProfile?> get profileStream => _profileController.stream;

  @override
  Future<UserProfile?> fetchCurrentUserProfile() async {
    final user = _remoteDataSource.currentUser;
    debugPrint('UserRepositoryImpl: Current Auth user is ${user?.uid}');
    if (user == null) {
      _profileController.add(null);
      return null;
    }
    final profile = await _userService.getUserProfile(user.uid);
    _profileController.add(profile);
    return profile;
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    await _userService.updateUserProfile(profile);
    _profileController.add(profile);
  }
}
