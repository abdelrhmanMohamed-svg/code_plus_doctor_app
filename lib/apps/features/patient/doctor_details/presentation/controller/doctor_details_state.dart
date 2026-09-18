import 'package:flutter/foundation.dart';

/// Immutable state for the Doctor Details screen.
class DoctorDetailsState {
  const DoctorDetailsState({this.favoritedIds = const {}});

  final Set<String> favoritedIds;

  bool isFavorited(String id) => favoritedIds.contains(id);

  DoctorDetailsState copyWith({Set<String>? favoritedIds}) =>
      DoctorDetailsState(favoritedIds: favoritedIds ?? this.favoritedIds);

  @override
  bool operator ==(Object other) =>
      other is DoctorDetailsState &&
      setEquals(other.favoritedIds, favoritedIds);

  @override
  int get hashCode => Object.hashAllUnordered(favoritedIds);
}
