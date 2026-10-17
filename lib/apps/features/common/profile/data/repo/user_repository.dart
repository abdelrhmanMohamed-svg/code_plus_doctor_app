import '../models/user_profile.dart';

/// Abstract user repository contract.
abstract class UserRepository {
  /// Stream of the user profile, updated whenever fetched or modified.
  Stream<UserProfile?> get profileStream;

  /// Returns the current authenticated user's profile, or null if unavailable.
  Future<UserProfile?> fetchCurrentUserProfile();

  /// Updates the user profile.
  Future<void> updateUserProfile(UserProfile profile);
}
