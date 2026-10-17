import '../../data/models/user_profile.dart';

/// Immutable state for the user session.
class UserState {
  const UserState({this.profile, this.isLoading = false});

  final UserProfile? profile;
  final bool isLoading;

  UserState copyWith({UserProfile? profile, bool? isLoading}) => UserState(
        profile: profile ?? this.profile,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  bool operator ==(Object other) =>
      other is UserState && other.profile == profile && other.isLoading == isLoading;

  @override
  int get hashCode => Object.hash(profile, isLoading);
}
