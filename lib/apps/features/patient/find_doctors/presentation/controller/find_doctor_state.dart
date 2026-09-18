import 'package:flutter/foundation.dart';

/// Immutable state tracking which doctors are favorited on the
/// Find Doctors screen.
class FindDoctorState {
  const FindDoctorState({this.favoritedIds = const {}});

  final Set<String> favoritedIds;

  bool isFavorited(String id) => favoritedIds.contains(id);

  FindDoctorState copyWith({Set<String>? favoritedIds}) =>
      FindDoctorState(favoritedIds: favoritedIds ?? this.favoritedIds);

  @override
  bool operator ==(Object other) =>
      other is FindDoctorState && setEquals(other.favoritedIds, favoritedIds);

  @override
  int get hashCode => Object.hashAllUnordered(favoritedIds);
}
