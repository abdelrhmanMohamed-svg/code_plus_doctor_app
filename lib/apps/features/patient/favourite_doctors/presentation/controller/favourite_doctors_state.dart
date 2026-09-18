import 'package:flutter/foundation.dart';

/// Immutable state tracking which doctors are favorited on the
/// Favourite Doctors screen.
class FavouriteDoctorsState {
  const FavouriteDoctorsState({this.favoritedIds = const {}});

  final Set<String> favoritedIds;

  bool isFavorited(String id) => favoritedIds.contains(id);

  FavouriteDoctorsState copyWith({Set<String>? favoritedIds}) =>
      FavouriteDoctorsState(favoritedIds: favoritedIds ?? this.favoritedIds);

  @override
  bool operator ==(Object other) =>
      other is FavouriteDoctorsState &&
      setEquals(other.favoritedIds, favoritedIds);

  @override
  int get hashCode => Object.hashAllUnordered(favoritedIds);
}
