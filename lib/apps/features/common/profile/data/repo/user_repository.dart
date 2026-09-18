import '../models/user_profile.dart';

/// Abstract user repository contract.
abstract class UserRepository {
  /// Returns the current authenticated user's profile, or null if unavailable.
  Future<UserProfile?> fetchCurrentUserProfile();
}
