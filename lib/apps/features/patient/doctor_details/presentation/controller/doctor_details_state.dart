import 'package:flutter/foundation.dart';

/// Immutable state for the Doctor Details screen.
class DoctorDetailsState {
  const DoctorDetailsState({
    this.favoritedIds = const {},
    this.hasError = false,
    this.errorMessage,
  });

  final Set<String> favoritedIds;
  final bool hasError;
  final String? errorMessage;

  bool isFavorited(String id) => favoritedIds.contains(id);

  DoctorDetailsState copyWith({
    Set<String>? favoritedIds,
    bool? hasError,
    String? errorMessage,
    bool clearError = false,
  }) =>
      DoctorDetailsState(
        favoritedIds: favoritedIds ?? this.favoritedIds,
        hasError: hasError ?? this.hasError,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );

  @override
  bool operator ==(Object other) =>
      other is DoctorDetailsState &&
      setEquals(other.favoritedIds, favoritedIds) &&
      other.hasError == hasError &&
      other.errorMessage == errorMessage;

  @override
  int get hashCode => Object.hash(Object.hashAllUnordered(favoritedIds), hasError, errorMessage);
}
